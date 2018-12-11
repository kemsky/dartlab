import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';

AppState appReducer(AppState previous, dynamic action) {
  if (action is SetRouteAction) {
    return previous.rebuild((builder) {
      builder.route = action.payload;
    });
  } else if (action is SetCurrentUserAction) {
    return previous.rebuild((builder) {
      builder.currentUser.replace(action.payload);
    });
  } else if (action is SetPackageInfoAction) {
    return previous.rebuild((builder) {
      builder.applicationInfo.update((builder) {
        builder.appName = action.appName;
        builder.buildNumber = action.buildNumber;
        builder.version = action.version;
        builder.packageName = action.packageName;
      });
    });
  } else {
    return previous;
  }
}
