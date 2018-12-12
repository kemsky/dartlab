library database_client;

import 'package:dart_lab/database/database_manager.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseClient {

  Observable<List<Map<String, dynamic>>> query(String query, [List<dynamic> arguments]);

  Observable<int> update(String query, [List<dynamic> arguments]);

  Observable<int> count(String query, [List<dynamic> arguments]);

  Observable<int> insert(String query, [List<dynamic> arguments]);

  Observable<T> transaction<T>(Observable<T> action(DatabaseTransaction tx));

  factory DatabaseClient(DatabaseService service) {
    return DatabaseClientImpl(service);
  }
}

class DatabaseClientImpl implements DatabaseClient {
  static final Logger _logger = new Logger('DatabaseClientImpl');

  final DatabaseService _service;

  DatabaseClientImpl(this._service);

  Observable<List<Map<String, dynamic>>> query(String query, [List<dynamic> arguments]) {
    return this._service.database.flatMap((db) {
      return Observable.fromFuture(db.rawQuery(query, arguments));
    });
  }

  Observable<int> update(String query, [List<dynamic> arguments]) {
    return this._service.database.flatMap((db) {
      return Observable.fromFuture(db.rawUpdate(query, arguments));
    });
  }

  Observable<int> count(String query, [List<dynamic> arguments]) {
    return this._service.database.flatMap((db) {
      return Observable.fromFuture(db.rawQuery(query, arguments)).map((list) {
        return Sqflite.firstIntValue(list) ?? 0;
      });
    });
  }

  Observable<int> insert(String query, [List<dynamic> arguments]) {
    return this._service.database.flatMap((db) {
      return Observable.fromFuture(db.rawInsert(query, arguments));
    });
  }

  Observable<T> transaction<T>(Observable<T> action(DatabaseTransaction tx)) {
    return this._service.database.flatMap((db) {
      return Observable.fromFuture(db.transaction((tx) async {
        var observable = action(DatabaseTransaction(tx)).take(1);
        return await observable.first;
      }));
    });
  }
}

abstract class DatabaseTransaction {

  Observable<List<Map>> query(String query, [List<dynamic> arguments]);

  Observable<int> update(String query, [List<dynamic> arguments]);

  Observable<int> count(String query, [List<dynamic> arguments]);

  Observable<int> insert(String query, [List<dynamic> arguments]);

  factory DatabaseTransaction(Transaction tx) {
    return DatabaseTransactionImpl(tx);
  }
}

class DatabaseTransactionImpl implements DatabaseTransaction {
  static final Logger _logger = new Logger('DatabaseTransactionImpl');

  Observable<Transaction> _tx;

  DatabaseTransactionImpl(Transaction tx) {
    _tx = Observable.just(tx);
  }

  Observable<List<Map>> query(String query, [List<dynamic> arguments]) {
    return this._tx.flatMap((db) {
      return Observable.fromFuture(db.rawQuery(query, arguments));
    });
  }

  Observable<int> update(String query, [List<dynamic> arguments]) {
    return this._tx.flatMap((db) {
      return Observable.fromFuture(db.rawUpdate(query, arguments));
    });
  }

  Observable<int> count(String query, [List<dynamic> arguments]) {
    return this._tx.flatMap((db) {
      return Observable.fromFuture(db.rawQuery(query, arguments)).map((list) {
        return Sqflite.firstIntValue(list) ?? 0;
      });
    });
  }

  Observable<int> insert(String query, [List<dynamic> arguments]) {
    return this._tx.flatMap((db) {
      return Observable.fromFuture(db.rawInsert(query, arguments));
    });
  }
}
