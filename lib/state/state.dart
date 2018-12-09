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

  AppState({int counter, CurrentUser currentUser, String title, PackageInfo packageInfo}){
    this._counter = counter;
    this._currentUser = currentUser;
    this._title = title;
    this._packageInfo = packageInfo;
  }

  factory AppState.initial()
  {
    return AppState(
      counter: 0,
      title: 'DartLab',
      packageInfo: new PackageInfo(appName: '', version: '', buildNumber: '', packageName: ''),
    );
  }

  AppState clone({int counter, CurrentUser currentUser, String title, PackageInfo packageInfo}) {
    return AppState(
      counter: counter ?? this.counter,
      currentUser: currentUser ?? this.currentUser,
      title: title ?? this.title,
      packageInfo: packageInfo ?? this.packageInfo,
    );
  }
}

final Logger logger = new Logger('loggingMiddleware');

loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  logger.info(action.toString());

  next(action);
}
