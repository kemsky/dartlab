import 'package:dart_lab/components/application.dart';
import 'package:dart_lab/database/database_client.dart';
import 'package:dart_lab/database/database_manager.dart';
import 'package:dart_lab/database/database_repository.dart';
import 'package:dart_lab/database/model/application_user.dart';
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

void main(List<String> arguments) {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: [${rec.loggerName}]: ${rec.message}');
  });

  initializeReflectable();

  final dev_host = arguments.length == 2 ? arguments[0] : null;
  final dev_token = arguments.length == 2 ? arguments[1] : null;

  //create store
  final store = Store<AppState>(
      appReducer,
      initialState: AppState.initial(dev_host, dev_token),
      middleware: createAppStateMiddleware());

  //start application
  runApp(ApplicationStoreProvider(store));

  store.dispatch(loadPackageInfoAction);
  store.dispatch(getCurrentUserAction);

  var databaseClient = DatabaseClient(DatabaseService());

  var repository = DatabaseRepository(databaseClient);

  UserRepository(repository).save(ApplicationUser((b) {
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

  UserRepository(repository).get().listen((data) {
    print('tx data $data');
  }, onDone: () {
    logger.info('tx done');
  }, onError: (e) {
    logger.info('tx error', e);
  });
}
