library middleware;

import 'package:dart_lab/components/application.dart';
import 'package:dart_lab/routes.dart';
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
    TypedMiddleware<AppState, SetCurrentUserAction>(setCurrentRoute),
    thunkMiddleware
  ];
}

Middleware<AppState> _setCurrentRoute() {
  return (Store<AppState> store, action, NextDispatcher next) {
    if (action is SetRouteAction) {
      if (action.sync) {
        switch (action.routerAction) {
          case RouterAction.pop:
            navigatorKey.currentState.pop(action.payload);
            break;
          case RouterAction.push:
            navigatorKey.currentState.pushNamed(action.payload);
            break;
          case RouterAction.replace:
            navigatorKey.currentState.pushReplacementNamed(action.payload);
            break;
          case RouterAction.remove:
            throw 'not implemented: ${action.routerAction}';
            break;
        }
      } else {
        next(action);
      }
    } else if (action is SetCurrentUserAction) {
      next(action);
      if (store.state.routerState.currentRoute.name != Routes.Activity) {
        navigatorKey.currentState.pushReplacementNamed(Routes.Activity);
      }
    }
  };
}

final Logger logger = new Logger('Action');

loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  logger.info(action.toString());

  next(action);
}
