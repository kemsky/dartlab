library reducers;

import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('Reducer');

AppState appReducer(AppState previous, dynamic action) {
  if (action is SetRouteAction && !action.isInitialRoute) {
    return previous.rebuild((builder) {
      builder.routerState.update((builder) {
        builder.url = action.appRoute.defaultUrl;
      });
      _logger.info(builder.routerState.build());
    });
  } else if (action is UpdateUserAction) {
    return previous.rebuild((builder) {
      builder.applicationUser.replace(action.user);
    });
  } else if (action is LoginUserAction) {
    return previous.rebuild((builder) {
      if (action.user != null) {
        builder.applicationUser.replace(action.user);
      } else {
        builder.applicationUser = null;
      }
    });
  } else if (action is SetPackageInfoAction) {
    return previous.rebuild((builder) {
      builder.applicationInfo.update((builder) {
        builder.appName = action.info.appName;
        builder.buildNumber = action.info.buildNumber;
        builder.version = action.info.version;
        builder.packageName = action.info.packageName;
      });
    });
  } else {
    return previous;
  }
}
