library middleware;

import 'package:dart_lab/components/application.dart';
import 'package:dart_lab/database/database_client.dart';
import 'package:dart_lab/database/database_manager.dart';
import 'package:dart_lab/database/database_repository.dart';
import 'package:dart_lab/database/model/application_user.dart';
import 'package:dart_lab/database/user_repository.dart';
import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/webapi/gitlab_api.dart';
import 'package:dart_lab/webapi/model/gitlab_current_user.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:dart_lab/state/state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:rxdart/rxdart.dart';

List<Middleware<AppState>> createAppStateMiddleware() {
  final routingMiddleware = RoutingMiddleware().create();
  final userMiddleware = UserMiddleWare().create();

  return [
    LoggingMiddleware().create(),
    TypedMiddleware<AppState, LoadPackageInfoAction>(LoadPackageInfoMiddleware().create()),
    TypedMiddleware<AppState, SetRouteAction>(routingMiddleware),
    TypedMiddleware<AppState, LoginUserAction>(routingMiddleware),
    TypedMiddleware<AppState, UpdateUserAction>(routingMiddleware),
    TypedMiddleware<AppState, LogoutUserAction>(routingMiddleware),
    TypedMiddleware<AppState, LogoutUserAction>(userMiddleware),
    TypedMiddleware<AppState, LoadUserAction>(userMiddleware),
    TypedMiddleware<AppState, AuthenticateUserAction>(userMiddleware),
    thunkMiddleware
  ];
}

class RoutingMiddleware {
  final Logger _logger = new Logger('RoutingMiddleware');

  Middleware<AppState> create() {
    return (Store<AppState> store, action, NextDispatcher next) {
      if (action is SetRouteAction) {
        var changed = action.appRoute.route != store.state.routerState.appRoute.route;

        if (action.appRoute.defaultUrl != store.state.routerState.appRoute.url) {
          next(action);
        }

        if (changed && action.sync) {
          navigatorKey.currentState.pushReplacementNamed(action.appRoute.route);
        }
      } else if (action is UpdateUserAction) {
        next(action);
        navigatorKey.currentState.pushReplacementNamed(Routes.ActivityActivity.route);
      } else if (action is LogoutUserAction) {
        navigatorKey.currentState.pushReplacementNamed(Routes.SetupScreen.route);
        next(action);
      } else if (action is LoginUserAction) {
        navigatorKey.currentState.pushReplacementNamed(Routes.ActivityActivity.route);
        next(action);
      }
    };
  }
}

class LoadPackageInfoMiddleware {
  final Logger _logger = new Logger('LoadPackageInfoMiddleware');

  Middleware<AppState> create() {
    return (Store<AppState> store, dynamic action, NextDispatcher next) async {
      final PackageInfo info = await PackageInfo.fromPlatform();
      store.dispatch(new SetPackageInfoAction(info));
    };
  }
}

class UserMiddleWare {
  final Logger _logger = new Logger('UserMiddleWare');

  Middleware<AppState> create() {
    return (Store<AppState> store, action, NextDispatcher next) {
      next(action);
      if (action is LogoutUserAction) {
        final repository = DatabaseRepository(DatabaseClient(DatabaseService()));
        repository.reset().listen((_) {
          _logger.info('Logout user');
        });
      } else if (action is LoadUserAction) {
        final repository = UserRepository(DatabaseRepository(DatabaseClient(DatabaseService())));

        repository.get().listen((optionalUser) {
          if (optionalUser.isNotEmpty) {
            final request = GitLabApi(optionalUser.value.host, optionalUser.value.token).getCurrentUser();

            request.listen((optionalRemoteUser) {
              if (optionalRemoteUser.isEmpty) {
                store.dispatch(LogoutUserAction());
              } else {
                final GitLabCurrentUser remoteUser = optionalRemoteUser.value;
                final ApplicationUser updatedUser = optionalUser.value.rebuild((builder) {
                  builder.fullName = remoteUser.name;
                  builder.avatarUrl = remoteUser.avatar_url;
                  builder.email = remoteUser.email;
                });
                store.dispatch(UpdateUserAction(updatedUser));
              }
            });
          } else {
            store.dispatch(LogoutUserAction());
          }
        });
      } else if (action is AuthenticateUserAction) {
        new GitLabApi(action.host, action.token).getCurrentUser().flatMap((optionalRemoteUser) {
          if (optionalRemoteUser.isEmpty) {
            return Observable.just(Optional<ApplicationUser>.absent());
          }
          final remoteUser = optionalRemoteUser.value;
          final repository = UserRepository(DatabaseRepository(DatabaseClient(DatabaseService())));
          final user = ApplicationUser((builder) {
            builder.token = action.token;
            builder.host = action.host;
            builder.avatarUrl = remoteUser.avatar_url;
            builder.email = remoteUser.email;
            builder.fullName = remoteUser.name;
          });
          return repository.save(user).map((_) => Optional.of(user));
        }).listen((optionalUser) {
          if (optionalUser.isNotEmpty) {
            store.dispatch(LoginUserAction(optionalUser.value));
          } else {
            Scaffold.of(action.context).showSnackBar(new SnackBar(
              content: new Text("Authentication failed"),
            ));
          }
        });
      }
    };
  }
}

class LoggingMiddleware {
  final Logger _logger = new Logger('LoggingMiddleware');

  Middleware<AppState> create() {
    return (Store<AppState> store, dynamic action, NextDispatcher next) {
      _logger.info(action.toString());
      next(action);
    };
  }
}
