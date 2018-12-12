import 'package:dart_lab/database/database_client.dart';
import 'package:dart_lab/database/model/database_serializers.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

class KeyValueRepository {
  final Logger logger = new Logger('KeyValueRepository');

  final DatabaseClient _client;

  KeyValueRepository(this._client);

  Observable<Map<String, dynamic>> load<T>(List<String> keys) {
    var selects = keys.map((key) => "SELECT key, value from KeyValue WHERE key = '$key'");
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

    //remove type name key
    values.remove('\$');

    var statement = 'INSERT OR REPLACE INTO KeyValue (key, value) VALUES ';
    statement += List.generate(values.length, (index) => index).map((i) => ' (?, ?)').join(', ');

    var params = [];

    values.forEach((key, value) {
      params.add(key);
      params.add(value);
    });

    logger.info('SQL: $statement');

    return this._client.query(statement, params);
  }
}
