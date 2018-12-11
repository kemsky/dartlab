import 'package:dart_lab/components/application.dart';
import 'package:dart_lab/database/database_client.dart';
import 'package:dart_lab/database/database_manager.dart';
import 'package:dart_lab/database/model/user.dart';
import 'package:dart_lab/database/user_repository.dart';
import 'package:dart_lab/middleware/middleware.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/reducers.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'main.reflectable.dart';

//todo: Add Error Reporting https://flutter.io/docs/cookbook/maintenance/error-reporting

void main() {
  //configure Logger package
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: [${rec.loggerName}]: ${rec.message}');
  });

  initializeReflectable();

  //create store
  final store = Store<AppState>(
      appReducer,
      initialState: AppState.initial(),
      middleware: createAppStateMiddleware());

  //start application
  runApp(ApplicationStoreProvider(store));

  store.dispatch(loadPackageInfoAction);
  store.dispatch(getCurrentUserAction);

  var databaseClient = DatabaseClient(DatabaseService());

  UserRepository(databaseClient).save(User((b) {
    return b
      ..token = 'token'
      ..url = 'https://gitlab.com';
  })).listen((_) {
    print('insert data');
  }, onError: (e) {
    logger.info('insert error', e);
  }, onDone: () {
    logger.info('insert done');
  });

  UserRepository(databaseClient).get().listen((data) {
    print('tx data $data');
  }, onDone: () {
    logger.info('tx done');
  }, onError: (e) {
    logger.info('tx error', e);
  });
}
