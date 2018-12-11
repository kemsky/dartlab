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
}

class SetPackageInfoAction {
  final PackageInfo payload;
  SetPackageInfoAction(this.payload);
}

class SetRouteAction {
  final String payload;
  final bool sync;
  SetRouteAction(this.payload, {this.sync = true});
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

  store.dispatch(new SetPackageInfoAction(info));
};