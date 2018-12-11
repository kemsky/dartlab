import 'package:dart_lab/state/state.dart';
import 'package:dart_lab/webapi/api.configuration.dart';
import 'package:dart_lab/webapi/model/current_user.dart';
import 'package:dart_lab/webapi/users.dart';
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class SetCurrentUserAction {
  final CurrentUser payload;

  SetCurrentUserAction(this.payload);

  @override
  String toString() {
    return 'SetCurrentUserAction{payload: $payload}';
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

class SetRouteAction {
  final String payload;
  final bool sync;
  final bool isInitialRoute;

  SetRouteAction(this.payload, {this.sync = true, this.isInitialRoute = false});

  @override
  String toString() {
    return 'SetRouteAction{payload: $payload, sync: $sync, isInitialRoute: $isInitialRoute}';
  }
}

ThunkAction<AppState> getCurrentUserAction = (Store<AppState> store) async {
  final Logger logger = new Logger('getCurrentUserAction');

  new Users(new Configuration())
      .getCurrentUser()
      .doOnData((user) {
    logger.info('success ${user.last_sign_in_at}');
    store.dispatch(new SetCurrentUserAction(user));
  }).listen((data) {});
};

ThunkAction<AppState> loadPackageInfoAction = (Store<AppState> store) async {
  final PackageInfo info = await PackageInfo.fromPlatform();

  store.dispatch(new SetPackageInfoAction(packageName: info.packageName, buildNumber: info.buildNumber, version: info.version, appName: info.appName));
};