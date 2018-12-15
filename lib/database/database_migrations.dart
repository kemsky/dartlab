library database_migrations;

import 'package:sqflite/sqflite.dart';

Future applyMigrations(Database db, int version) async {
  switch (version) {
    case 1:
      await db.execute("""
          CREATE TABLE KeyValue (
            key       TEXT PRIMARY KEY NOT NULL ON CONFLICT REPLACE,
            value     TEXT
          )
      """);
      break;
    default:
      throw 'Unsupported database version: $version';
  }
}

