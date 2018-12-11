import 'package:dart_lab/components/application.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:dart_lab/state/state.dart';
import 'package:redux_thunk/redux_thunk.dart';

List<Middleware<AppState>> createAppStateMiddleware() {
  final setCurrentRoute = _setCurrentRoute();
  return [
    loggingMiddleware,
    TypedMiddleware<AppState, SetRouteAction>(setCurrentRoute),
    thunkMiddleware
  ];
}

Middleware<AppState> _setCurrentRoute() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    if(action is SetRouteAction) {
      if (action.sync) {
        navigatorKey.currentState.pushNamed(action.payload);
      }
    }
  };
}

final Logger logger = new Logger('loggingMiddleware');

loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  logger.info(action.toString());

  next(action);
}