library state;

import 'package:built_collection/built_collection.dart';
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

abstract class ScreenState implements Built<ScreenState, ScreenStateBuilder> {
  static Serializer<ScreenState> get serializer => _$screenStateSerializer;

  String get name;

  bool get isInitialScreen;

  ScreenState._();

  factory ScreenState([updates(ScreenStateBuilder b)]) =_$ScreenState;
}

abstract class ScreensState implements Built<ScreensState, ScreensStateBuilder> {
  static Serializer<ScreensState> get serializer => _$screensStateSerializer;

  BuiltList<ScreenState> get screens;

  ScreenState get currentScreen => screens.last;

  ScreensState._();

  factory ScreensState([updates(ScreensStateBuilder b)]) =_$ScreensState;
}

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  ApplicationInfo get applicationInfo;

  @nullable
  GitLabCurrentUser get currentUser;

  String get title;

  ScreensState get screenState;

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
      builder.screenState.update((builder){
        builder.screens.update((builder) {
          builder.add(ScreenState((builder){
            builder.name = '/';
            builder.isInitialScreen = true;
          }));
        });
      });
    });
  }

  @memoized
  ApplicationDrawerModel getApplicationDrawerModel() {
    return ApplicationDrawerModel(this.screenState.currentScreen, this.currentUser);
  }

  AppState._();

  factory AppState([updates(AppStateBuilder b)]) =_$AppState;
}