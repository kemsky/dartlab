import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:package_info/package_info.dart';

AppState appReducer(AppState previous, dynamic action) {
  switch (action.type) {
    case Actions.INCREMENT:
      return previous.rebuild((builder) {
        builder.counter = builder.counter + 1;
      });
    case Actions.DECREMENT:
      return previous.rebuild((builder) {
        builder.counter = builder.counter - 1;
      });
    case Actions.SET_CURRENT_USER:
      return previous.rebuild((builder) {
        builder.counter = builder.counter + 1;
        builder.currentUser.replace(action.payload);
      });
    case Actions.SET_PACKAGE_INFO:
      return previous.rebuild((builder) {
        builder.counter = builder.counter + 1;

        var packageInfo = action.payload as PackageInfo;

        builder.appName = packageInfo.appName;
        builder.buildNumber = packageInfo.buildNumber;
        builder.version = packageInfo.version;
        builder.packageName = packageInfo.packageName;
      });
    default:
      return previous;
  }
}
