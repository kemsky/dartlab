import 'package:dart_lab/application.dart';
import 'package:dart_lab/state/reducers.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

//todo: Add Error Reporting https://flutter.io/docs/cookbook/maintenance/error-reporting

void main() {
  //configure Logger package
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  //create store
  final store = new Store<AppState>(
      appReducer,
      initialState: new AppState(0, null, 'DartLab'),
      middleware: [loggingMiddleware, thunkMiddleware]
  );

  //start application
  runApp(new ApplicationStoreProvider(store));
}