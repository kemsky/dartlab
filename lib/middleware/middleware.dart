library middleware;

import 'package:dart_lab/components/application.dart';
import 'package:dart_lab/screens.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:dart_lab/state/state.dart';
import 'package:redux_thunk/redux_thunk.dart';

List<Middleware<AppState>> createAppStateMiddleware() {
  final setCurrentRoute = _setCurrentRoute();
  return [
    loggingMiddleware,
    TypedMiddleware<AppState, SetScreenAction>(setCurrentRoute),
    TypedMiddleware<AppState, SetCurrentUserAction>(setCurrentRoute),
    thunkMiddleware
  ];
}

Middleware<AppState> _setCurrentRoute() {
  return (Store<AppState> store, action, NextDispatcher next) {
    if (action is SetScreenAction) {
      if (action.sync) {
        switch (action.screenAction) {
          case ScreenAction.pop:
            navigatorKey.currentState.pop(action.screen);
            break;
          case ScreenAction.push:
            navigatorKey.currentState.pushNamed(action.screen);
            break;
          case ScreenAction.replace:
            navigatorKey.currentState.pushReplacementNamed(action.screen);
            break;
          case ScreenAction.remove:
            throw 'not implemented: ${action.screenAction}';
            break;
        }
      } else {
        next(action);
      }
    } else if (action is SetCurrentUserAction) {
      next(action);
      if (store.state.screenState.currentScreen.name != Screens.ApplicationScreen) {
        navigatorKey.currentState.pushNamed(Screens.ApplicationScreen);
      }
    }
  };
}

final Logger logger = new Logger('Action');

loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  logger.info(action.toString());

  next(action);
}
