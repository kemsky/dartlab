import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

class AppState {
  int _counter;

  int get counter => _counter;

  AppState(this._counter);
}

final Logger logger = new Logger('loggingMiddleware');

loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  logger.info('${new DateTime.now()}: $action');

  next(action);
}
