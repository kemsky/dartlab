import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dart_lab/webapi/model/current_user.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

part 'state.g.dart';

class AboutPageView
{
  final String appName;

  final String packageName;

  final String version;

  final String buildNumber;

  AboutPageView({this.appName, this.packageName, this.version, this.buildNumber});
}

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  /// The app name. `CFBundleDisplayName` on iOS, `application/label` on Android.
  String get appName;

  /// The package name. `bundleIdentifier` on iOS, `getPackageName` on Android.
  String get packageName;

  /// The package version. `CFBundleShortVersionString` on iOS, `versionName` on Android.
  String get version;

  /// The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
  String get buildNumber;

  int get counter;

  @nullable
  CurrentUser get currentUser;

  String get title;

  static AppState initial()
  {
    return AppState((builder) {
      builder.counter = 0;
      builder.title = 'DartLab';
      builder.appName = '';
      builder.packageName = '';
      builder.version = '';
      builder.buildNumber = '';
    });
  }

  AppState._();

  factory AppState([updates(AppStateBuilder b)]) =_$AppState;

  @memoized
  AboutPageView getAboutPage(){
    return AboutPageView(appName: this.appName, packageName: this.packageName, version: this.version, buildNumber: this.buildNumber);
  }
}

final Logger logger = new Logger('loggingMiddleware');

loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  logger.info(action.toString());

  next(action);
}
