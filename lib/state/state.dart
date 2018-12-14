library state;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dart_lab/components/application_drawer.dart';
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

abstract class RouterState implements Built<RouterState, RouterStateBuilder> {
  static Serializer<RouterState> get serializer => _$routerStateSerializer;

  String get url;

  @memoized
  String get route => url.split('/').first;

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

  String get host;

  String get token;

  static AppState initial(String dev_host, String dev_token)
  {
    return AppState((builder) {
      builder.title = 'DartLab';
      builder.applicationInfo.version = '';
      builder.applicationInfo.buildNumber = '';
      builder.applicationInfo.packageName = '';
      builder.applicationInfo.appName = '';
      builder.host = dev_host;
      builder.token = dev_token;
      builder.routerState.update((builder){
         builder.url = '/';
      });
    });
  }

  @memoized
  ApplicationDrawerModel getApplicationDrawerModel() {
    return ApplicationDrawerModel(this.routerState, this.currentUser);
  }

  AppState._();

  factory AppState([updates(AppStateBuilder b)]) =_$AppState;
}