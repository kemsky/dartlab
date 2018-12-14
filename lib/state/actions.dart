library actions;

import 'package:dart_lab/state/state.dart';
import 'package:dart_lab/webapi/model/gitlab_current_user.dart';
import 'package:dart_lab/webapi/gitlab_api.dart';
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class SetCurrentUserAction {
  final GitLabCurrentUser currentUser;

  SetCurrentUserAction(this.currentUser);

  @override
  String toString() {
    return 'SetCurrentUserAction{payload: $currentUser}';
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

class SetScreenAction {
  final String url;
  final bool sync;
  final bool isInitialRoute;
  final NavigatorAction navigatorAction;

  SetScreenAction(this.url, this.navigatorAction, {this.sync = true, this.isInitialRoute = false});

  @override
  String toString() {
    return 'SetScreenAction{url: $url, sync: $sync, isInitialScreen: $isInitialRoute, navigatorAction: $navigatorAction}';
  }
}

ThunkAction<AppState> getCurrentUserAction = (Store<AppState> store) async {
  final Logger logger = new Logger('getCurrentUserAction');

  new GitLabApi(store.state.host, store.state.token).getCurrentUser().doOnData((user) {
    logger.info('success ${user.last_sign_in_at}');
    store.dispatch(new SetCurrentUserAction(user));
  }).listen((data) {});
};

ThunkAction<AppState> loadPackageInfoAction = (Store<AppState> store) async {
  final PackageInfo info = await PackageInfo.fromPlatform();

  store.dispatch(new SetPackageInfoAction(packageName: info.packageName, buildNumber: info.buildNumber, version: info.version, appName: info.appName));
};
