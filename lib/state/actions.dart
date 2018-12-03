import 'package:dart_lab/state/state.dart';
import 'package:dart_lab/webapi/model/current.user.dart';
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:dart_lab/webapi/api.configuration.dart';
import 'package:dart_lab/webapi/users.dart';

enum Actions {
  INCREMENT,
  DECREMENT,
  SET_CURRENT_USER,
  SET_PACKAGE_INFO,
}

abstract class Action<T, P> {
  final T type;
  final P payload;

  Action(this.type, {this.payload});

  @override
  String toString() {
    return 'Action{type: $type, payload: $payload}';
  }
}

class IncrementAction extends Action<Actions, void> {
  IncrementAction() : super(Actions.INCREMENT);
}

class DecrementAction extends Action<Actions, void> {
  DecrementAction() : super(Actions.DECREMENT);
}

class SetCurrentUserAction extends Action<Actions, CurrentUser> {
  SetCurrentUserAction(CurrentUser payload)
      : super(Actions.SET_CURRENT_USER, payload: payload);
}

class SetPackageInfoAction extends Action<Actions, PackageInfo> {
  SetPackageInfoAction(PackageInfo payload)
      : super(Actions.SET_PACKAGE_INFO, payload: payload);
}

ThunkAction<AppState> getCurrentUserAction = (Store<AppState> store) async {
  final Logger logger = new Logger('getCurrentUserAction');

  final response = new Users(new Configuration()).getCurrentUser();

  var user = await response.then((user) {
    logger.info('success ${user.last_sign_in_at}');
    return user;
  });

  store.dispatch(new SetCurrentUserAction(user));
};

ThunkAction<AppState> loadPackageInfoAction = (Store<AppState> store) async {
  final PackageInfo info = await PackageInfo.fromPlatform();

  store.dispatch(new SetPackageInfoAction(info));
};
