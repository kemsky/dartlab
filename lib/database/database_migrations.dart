part of database_manager;

Future _onCreate(Database db, int version) async {
  switch (version) {
    case 1:
      await db.execute('CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
      break;
    default:
      throw 'Unsupported database version: $version';
  }
}

