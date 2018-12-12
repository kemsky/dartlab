library state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dart_lab/webapi/model/gitlab_current_user.dart';

part 'state.g.dart';

abstract class ApplicationInfo implements Built<ApplicationInfo, ApplicationInfoBuilder>
{
  static Serializer<ApplicationInfo> get serializer => _$applicationInfoSerializer;

  String get appName;

  String get packageName;

  String get version;

  String get buildNumber;

  ApplicationInfo._();

  factory ApplicationInfo([updates(ApplicationInfoBuilder b)]) =_$ApplicationInfo;
}

abstract class RouteState implements Built<RouteState, RouteStateBuilder> {
  static Serializer<RouteState> get serializer => _$routeStateSerializer;

  String get name;

  bool get isInitialRoute;

  RouteState._();

  factory RouteState([updates(RouteStateBuilder b)]) =_$RouteState;
}

abstract class RouterState implements Built<RouterState, RouterStateBuilder> {
  static Serializer<RouterState> get serializer => _$routerStateSerializer;

  BuiltList<RouteState> get routes;

  RouteState get currentRoute => routes.last;

  RouterState._();

  factory RouterState([updates(RouterStateBuilder b)]) =_$RouterState;
}

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  ApplicationInfo get applicationInfo;

  @nullable
  GitLabCurrentUser get currentUser;

  String get title;

  RouterState get routerState;

  static AppState initial(String dev_host, String dev_token)
  {
    return AppState((builder) {
      builder.title = 'DartLab';
      builder.applicationInfo.version = '';
      builder.applicationInfo.buildNumber = '';
      builder.applicationInfo.packageName = '';
      builder.applicationInfo.appName = '';
      builder.routerState.update((builder){
        builder.routes.update((builder) {
          builder.add(RouteState((builder){
            builder.name = '/';
            builder.isInitialRoute = true;
          }));
        });
      });
    });
  }

  AppState._();

  factory AppState([updates(AppStateBuilder b)]) =_$AppState;
}