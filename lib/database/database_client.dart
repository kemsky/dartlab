library database_client;

import 'package:dart_lab/database/database_manager.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  final DatabaseService _service;

  DatabaseClient(this._service);

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

class DatabaseTransaction {
  Observable<Transaction> _tx;

  DatabaseTransaction(Transaction tx) {
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
