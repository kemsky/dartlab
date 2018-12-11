import 'package:dart_lab/state/state.dart';
import 'package:dart_lab/webapi/api.configuration.dart';
import 'package:dart_lab/webapi/model/current_user.dart';
import 'package:dart_lab/webapi/users.dart';
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

abstract class Action<P> {
  final P payload;

  Action({this.payload});
}

class IncrementAction extends Action<void> {
  IncrementAction();
}

class DecrementAction extends Action<void> {
  DecrementAction();
}

class SetCurrentUserAction extends Action<CurrentUser> {
  SetCurrentUserAction(CurrentUser payload): super(payload: payload);
}

class SetPackageInfoAction extends Action<PackageInfo> {
  SetPackageInfoAction(PackageInfo payload): super(payload: payload);
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
