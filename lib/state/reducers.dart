library reducers;

import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';

AppState appReducer(AppState previous, dynamic action) {
  if (action is SetRouteAction && !action.isInitialRoute) {
    return previous.rebuild((builder) {
      builder.routerState.update((builder) {
        builder.url = action.appRoute.defaultUrl;
      });
      print(builder.routerState.build());
    });
  } else if (action is SetApplicationUserAction) {
    return previous.rebuild((builder) {
      if (action.applicationUser != null) {
        builder.applicationUser.replace(action.applicationUser);
      } else {
        builder.applicationUser = null;
      }
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
