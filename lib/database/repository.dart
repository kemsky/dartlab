import 'package:dart_lab/database/database_client.dart';
import 'package:dart_lab/database/model/database_serializers.dart';
import 'package:dart_lab/reflection/reflectable.dart';
import 'package:logging/logging.dart';
import 'package:reflectable/reflectable.dart';
import 'package:rxdart/rxdart.dart';

class KeyValueRepository {
  static final Map<String, bool> IgnoredProperties = {
    'hashCode': true,
    '==': true,
    'noSuchMethod': true,
    'toString': true,
    'runtimeType': true,
    'serializer': true,
  };

  final Logger logger = new Logger('KeyValueRepository');

  final DatabaseClient _client;

  KeyValueRepository(this._client);

  Observable<Map<String, dynamic>> load(Type entityType) {
    ClassMirror classMirror = reflector.reflectType(entityType);
    var prefix = classMirror.simpleName;
    var selects = getKeys(classMirror).map((key) => "SELECT SUBSTR(key, LENGTH('${prefix}_') + 1) as key, value from KeyValue WHERE key = '${prefix}_${key}'");
    var statement = selects.join(' UNION ALL ');

    logger.info('SQL: $statement');

    return this._client.query(statement).map((rows) {
      Map<String, dynamic> result = new Map<String, dynamic>();
      rows.forEach((pair) {
        result[pair['key']] = pair['value'];
      });
      return result;
    });
  }

  Observable<void> save<T>(T entity) {
    Map<String, dynamic> values = model_serializers.serialize(entity);

    String prefix = values.remove('\$');

    var statement = 'INSERT OR REPLACE INTO KeyValue (key, value) VALUES ';
    statement += List.generate(values.length, (index) => index).map((i) => ' (?, ?)').join(', ');

    var params = [];

    values.forEach((key, value) {
      params.add('${prefix}_${key}');
      params.add(value);
    });

    logger.info('SQL: $statement, params: $params');

    return this._client.query(statement, params);
  }

  Observable<void> delete<T>(Type entityType) {
    ClassMirror classMirror = reflector.reflectType(entityType);
    var prefix = classMirror.simpleName;
    var where = classMirror.instanceMembers.keys.map((key) => "key = '${prefix}_${key}'");
    var statement = 'DELETE FROM KeyValue WHERE ' + where.join(' OR ');

    logger.info('SQL: $statement');

    return this._client.query(statement);
  }

  Iterable<String> getKeys(ClassMirror classMirror) {
    return classMirror.declarations.keys.where((key) {
      return key != classMirror.simpleName && !IgnoredProperties.containsKey(key);
    });
  }
}
