library actions;

import 'package:dart_lab/database/database_client.dart';
import 'package:dart_lab/database/database_manager.dart';
import 'package:dart_lab/database/database_repository.dart';
import 'package:dart_lab/database/model/application_user.dart';
import 'package:dart_lab/database/user_repository.dart';
import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/state.dart';
import 'package:dart_lab/webapi/model/gitlab_current_user.dart';
import 'package:dart_lab/webapi/gitlab_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:rxdart/rxdart.dart';

class SetCurrentUserAction {
  final GitLabCurrentUser currentUser;

  SetCurrentUserAction(this.currentUser);

  @override
  String toString() {
    return 'SetCurrentUserAction{payload: $currentUser}';
  }
}

class SetApplicationUserAction {
  final ApplicationUser applicationUser;

  SetApplicationUserAction(this.applicationUser);

  @override
  String toString() {
    return 'SetApplicationUserAction{applicationUser: $applicationUser}';
  }
}

class SetPackageInfoAction {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;

  SetPackageInfoAction({
    this.appName,
    this.packageName,
    this.version,
    this.buildNumber,
  });

  @override
  String toString() {
    return 'SetPackageInfoAction{appName: $appName, packageName: $packageName, version: $version, buildNumber: $buildNumber}';
  }
}

enum NavigatorAction { push, pop, remove, replace }

class SetRouteAction {
  final AppRoute appRoute;
  final bool sync;
  final bool drawer;
  final bool isInitialRoute;
  final NavigatorAction navigatorAction;

  SetRouteAction(this.appRoute, {this.navigatorAction = NavigatorAction.replace, this.sync = true, this.drawer = false, this.isInitialRoute = false});

  @override
  String toString() {
    return 'SetRouteAction{appRoute: $appRoute, sync: $sync, isInitialRoute: $isInitialRoute, navigatorAction: $navigatorAction}';
  }
}

ThunkAction<AppState> loginUser(String host, String token, BuildContext context) {
  return (Store<AppState> store) async {
    final Logger logger = new Logger('loginUser');

    new GitLabApi(host, token).getCurrentUser().flatMap((optionalRemoteUser) {
      if (optionalRemoteUser.isEmpty) {
        return Observable.just(Optional<ApplicationUser>.absent());
      }
      final remoteUser = optionalRemoteUser.value;
      final repository = UserRepository(DatabaseRepository(DatabaseClient(DatabaseService())));
      final user = ApplicationUser((builder) {
        builder.token = token;
        builder.host = host;
        builder.avatarUrl = remoteUser.avatar_url;
        builder.email = remoteUser.email;
        builder.fullName = remoteUser.name;
      });
      return repository.save(user).map((_) => Optional.of(user));
    }).listen((optionalUser) {
      if (optionalUser.isNotEmpty) {
        store.dispatch(SetApplicationUserAction(optionalUser.value));
      } else {
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Invalid credentials"),
        ));
      }
    });
  };
}

ThunkAction<AppState> loadPackageInfoAction = (Store<AppState> store) async {
  final PackageInfo info = await PackageInfo.fromPlatform();

  store.dispatch(new SetPackageInfoAction(packageName: info.packageName, buildNumber: info.buildNumber, version: info.version, appName: info.appName));
};
