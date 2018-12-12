import 'package:dart_lab/components/application.dart';
import 'package:dart_lab/middleware/middleware.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/reducers.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'main.reflectable.dart';
import 'package:reflectable/reflectable.dart';

//todo: Add Error Reporting https://flutter.io/docs/cookbook/maintenance/error-reporting

final Logger _logger = new Logger('main');

void main(List<String> arguments) {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: [${rec.loggerName}]: ${rec.message}');
  });

  _logger.info("Starting application...");

  initializeReflectable();

  final dev_host = arguments.length == 2 ? arguments[0] : null;
  final dev_token = arguments.length == 2 ? arguments[1] : null;

  if (arguments.length > 0) {
    _logger.info("Development mode: host='$dev_host', token='$dev_token'");
  }

  final store = Store<AppState>(
      appReducer,
      initialState: AppState.initial(dev_host, dev_token),
      middleware: createAppStateMiddleware());

  runApp(ApplicationStoreProvider(store));

  store.dispatch(loadPackageInfoAction);
  store.dispatch(getCurrentUserAction);
}
