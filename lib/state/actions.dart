library actions;

import 'package:dart_lab/database/model/application_user.dart';
import 'package:dart_lab/routes.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class LoadUserAction {

  LoadUserAction();

  @override
  String toString() {
    return 'LoadUserAction{}';
  }
}

class AuthenticateUserAction {
  String token;
  String host;
  BuildContext context;

  AuthenticateUserAction(this.host, this.token, this.context);

  @override
  String toString() {
    return 'AuthenticateUserAction{token: $token, host: $host}';
  }
}

class LoginUserAction {
  final ApplicationUser user;

  LoginUserAction(this.user);

  @override
  String toString() {
    return 'LoginUserAction{user: $user}';
  }
}

class UpdateUserAction {
  final ApplicationUser user;

  UpdateUserAction(this.user);

  @override
  String toString() {
    return 'UpdateUserAction{user: $user}';
  }
}

class LogoutUserAction {
  LogoutUserAction();

  @override
  String toString() {
    return 'LogoutUserAction{}';
  }
}

class SetPackageInfoAction {
  final PackageInfo info;

  SetPackageInfoAction(this.info);

  @override
  String toString() {
    return 'SetPackageInfoAction{appName: ${info.appName}, packageName: ${info.packageName}, version: ${info.version}, buildNumber: ${info.buildNumber}}';
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

class LoadPackageInfoAction {

  LoadPackageInfoAction();

  @override
  String toString() {
    return 'LoadPackageInfoAction{}';
  }
}
