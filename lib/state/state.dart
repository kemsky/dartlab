import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dart_lab/components/application.dart';
import 'package:dart_lab/webapi/model/current_user.dart';
import 'package:flutter/material.dart' as material;
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

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

  material.NavigatorState get navigatorState {
    return navigatorKey.currentState;
  }

  static AppState initial()
  {
    return AppState((builder) {
      builder.title = 'DartLab';
      builder.applicationInfo.version = '';
      builder.applicationInfo.buildNumber = '';
      builder.applicationInfo.packageName = '';
      builder.applicationInfo.appName = '';
    });
  }

  AppState._();

  factory AppState([updates(AppStateBuilder b)]) =_$AppState;
}

final Logger logger = new Logger('loggingMiddleware');

loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  logger.info(action.toString());

  next(action);
}
