import 'package:dart_lab/webapi/model/current.user.dart';
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';

class AppState {
  int _counter;
  CurrentUser _currentUser;
  String _title;
  PackageInfo _packageInfo;

  int get counter => _counter;
  CurrentUser get currentUser => _currentUser;
  String get title => _title;
  PackageInfo get packageInfo => _packageInfo;

  AppState(this._counter, this._currentUser, this._title, this._packageInfo);
}

final Logger logger = new Logger('loggingMiddleware');

loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  logger.info(action.toString());

  next(action);
}
