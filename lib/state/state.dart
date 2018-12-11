import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dart_lab/webapi/model/current_user.dart';

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

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  ApplicationInfo get applicationInfo;

  @nullable
  CurrentUser get currentUser;

  String get title;

  String get route;

  static AppState initial()
  {
    return AppState((builder) {
      builder.title = 'DartLab';
      builder.route = '/';
      builder.applicationInfo.version = '';
      builder.applicationInfo.buildNumber = '';
      builder.applicationInfo.packageName = '';
      builder.applicationInfo.appName = '';
    });
  }

  AppState._();

  factory AppState([updates(AppStateBuilder b)]) =_$AppState;
}