import 'package:dart_lab/webapi/model/current.user.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

class AppState {
  int _counter;
  CurrentUser _currentUser;

  int get counter => _counter;
  CurrentUser get currentUser => _currentUser;

  AppState(this._counter, this._currentUser);
}

final Logger logger = new Logger('loggingMiddleware');

loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  logger.info('${new DateTime.now()}: $action');

  next(action);
}
