library state;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dart_lab/database/model/application_user.dart';
import 'package:dart_lab/routes.dart';

part 'state.g.dart';

abstract class ApplicationInfo implements Built<ApplicationInfo, ApplicationInfoBuilder> {
  static Serializer<ApplicationInfo> get serializer => _$applicationInfoSerializer;

  String get appName;

  String get packageName;

  String get version;

  String get buildNumber;

  ApplicationInfo._();

  factory ApplicationInfo([updates(ApplicationInfoBuilder b)]) = _$ApplicationInfo;
}

abstract class RouterState implements Built<RouterState, RouterStateBuilder> {
  static Serializer<RouterState> get serializer => _$routerStateSerializer;

  String get url;

  AppRoute get appRoute {
    return Routes.map[this.url];
  }

  String get route => appRoute.route;

  RouterState._();

  factory RouterState([updates(RouterStateBuilder b)]) = _$RouterState;
}

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  ApplicationInfo get applicationInfo;

  @nullable
  ApplicationUser get applicationUser;

  RouterState get routerState;

  ///Development only
  String get host;

  ///Development only
  String get token;

  static AppState initial(String host, String token) {
    return AppState((builder) {
      builder.applicationInfo.version = '';
      builder.applicationInfo.buildNumber = '';
      builder.applicationInfo.packageName = '';
      builder.applicationInfo.appName = '';
      builder.host = host;
      builder.token = token;
      builder.routerState.update((builder) {
        builder.url = '/';
      });
    });
  }

  AppState._();

  factory AppState([updates(AppStateBuilder b)]) = _$AppState;
}
