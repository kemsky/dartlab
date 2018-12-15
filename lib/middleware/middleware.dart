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
    TypedMiddleware<AppState, SetApplicationUserAction>(setCurrentRoute),
    thunkMiddleware
  ];
}

Middleware<AppState> _setCurrentRoute() {
  return (Store<AppState> store, action, NextDispatcher next) {
    if (action is SetRouteAction) {
      var changed = action.appRoute.route != store.state.routerState.appRoute.route;

      if (action.appRoute.defaultUrl != store.state.routerState.appRoute.url) {
        next(action);
      }

      if (changed && action.sync) {
        navigatorKey.currentState.pushReplacementNamed(action.appRoute.route);
      }
    } else if (action is SetApplicationUserAction) {
      next(action);
      if (action.applicationUser == null) {
        navigatorKey.currentState.pushReplacementNamed(Routes.SetupScreen.route);
      } else {
        navigatorKey.currentState.pushReplacementNamed(Routes.ActivityActivity.route);
      }
    }
  };
}

final Logger logger = new Logger('Action');

loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  logger.info(action.toString());

  next(action);
}
