library database_migrations;

import 'package:dart_lab/database/model/user.dart';
import 'package:sqflite/sqflite.dart';

Future applyMigrations(Database db, int version) async {
  switch (version) {
    case 1:
      await db.execute("""
          CREATE TABLE ${User.TableName} (
            id        INTEGER PRIMARY KEY,
            token     TEXT NOT NULL,
            url       TEXT NOT NULL,
            fullName  TEXT,
            email     TEXT,
            avatarUrl TEXT
          )
      """);
      break;
    default:
      throw 'Unsupported database version: $version';
  }
}

