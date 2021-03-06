library database_repository;

import 'dart:convert';

import 'package:built_value/serializer.dart';
import 'package:dart_lab/database/database_client.dart';
import 'package:dart_lab/database/model/database_serializers.dart';
import 'package:logging/logging.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

abstract class DatabaseRepository {

  Observable<Optional<T>> load<T>(String key, Type entityType);

  Observable<void> save<T>(String key, T entity);

  Observable<void> delete(String key);

  Observable<void> reset();

  factory DatabaseRepository(DatabaseClient client) {
    return DatabaseRepositoryImpl(client);
  }
}

class DatabaseRepositoryImpl implements DatabaseRepository {
  static final Logger _logger = new Logger('DatabaseRepositoryImpl');

  final DatabaseClient _client;

  DatabaseRepositoryImpl(this._client);

  Observable<Optional<T>> load<T>(String key, Type entityType) {
    final statement = "SELECT key, value from KeyValue WHERE key = ?";

    final params = [key];

    _logger.info('SQL: $statement, params: $params');

    return this._client.query(statement, params).map((rows) {
      if (rows.isEmpty) {
        return Optional.absent();
      }
      String result = rows.first['value'];

      return Optional.of(database_serializers.deserialize(json.decode(result), specifiedType: FullType(entityType)));
    });
  }

  Observable<void> save<T>(String key, T entity) {
    final Map<String, dynamic> values = database_serializers.serialize(entity);

    values.remove('\$');

    final statement = 'INSERT OR REPLACE INTO KeyValue (key, value) VALUES (?, ?)';

    final params = [key, json.encode(values)];

    _logger.info('SQL: $statement, params: $params');

    return this._client.query(statement, params);
  }

  Observable<void> delete(String key) {
    final statement = 'DELETE FROM KeyValue WHERE key = ?';

    final params = [key];

    _logger.info('SQL: $statement, params: $params');

    return this._client.query(statement, params);
  }

  @override
  Observable<void> reset() {
    final statement = 'DELETE FROM KeyValue';

    _logger.info('SQL: $statement');

    return this._client.query(statement);
  }
}
