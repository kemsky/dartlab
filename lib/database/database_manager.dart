library database_manager;

import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dart_lab/database/database_migrations.dart';

abstract class DatabaseService {
  static DatabaseService _instance;

  String get databaseName;

  int get databaseVersion;

  Observable<Database> get database;

  Observable<Database> open(String path);

  Observable<void> close(Database db);

  Observable<void> delete(String databaseName);

  Observable<String> getPath(String databaseName);

  bool isOpen(Database db);

  factory DatabaseService() {
    if (_instance == null) {
      _instance = DatabaseServiceImpl();
    }
    return _instance;
  }
}

class DatabaseServiceImpl implements DatabaseService {
  static final Logger logger = new Logger('DatabaseServiceImpl');

  static const String _DatabaseName = 'database.db';
  static const int _DatabaseVersion = 1;

  String get databaseName => _DatabaseName;

  int get databaseVersion => _DatabaseVersion;

  Observable<Database> get database => this
      ._opening
      .flatMap((opening) {
        if (this.isOpen(this._database)) {
          return Observable.just(true);
        } else {
          if (opening || this._lock) {
            return Observable.just(false);
          }
          this._lock = true;
          _opening.add(true);
          return this.getPath(this.databaseName).flatMap(this.open).doOnData((db) {
            this._database = db;
            this._lock = false;
            _opening.add(false);
          }).map((_) => true);
        }
      })
      .where((opened) => opened)
      .take(1)
      .map((_) {
        return this._database;
      });

  Database _database;

  BehaviorSubject<bool> _opening = BehaviorSubject<bool>(seedValue: false);

  bool _lock = false;

  Observable<Database> open(String path) {
    logger.info('Open database `$path`, version: ${this.databaseVersion}');
    var future = openDatabase(path, version: this.databaseVersion, onCreate: applyMigrations);
    return Observable.fromFuture(future).doOnData((_) => logger.info('Open database success.'));
  }

  Observable<void> close(Database db) {
    if (!this.isOpen(db)) {
      return Observable.just(null);
    }
    return Observable.fromFuture(db.close());
  }

  Observable<void> delete(String databaseName) {
    return this.getPath(databaseName).flatMap((path) => Observable.fromFuture(deleteDatabase(path)));
  }

  Observable<String> getPath(String databaseName) {
    return Observable.fromFuture(getDatabasesPath()).map((databasesPath) => join(databasesPath, databaseName));
  }

  bool isOpen(Database db) => db != null && db.isOpen;
}
