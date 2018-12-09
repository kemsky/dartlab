import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dart_lab/webapi/model/current.user.dart';
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';

part 'state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  int get counter;
  @nullable
  CurrentUser get currentUser;
  String get title;
  PackageInfo get packageInfo;

  static AppState initial()
  {
    return AppState((builder) {
      builder.counter = 0;
      builder.title = 'DartLab';
      builder.packageInfo = new PackageInfo(appName: '', version: '', buildNumber: '', packageName: '');
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
