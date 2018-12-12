library reducers;

import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';

AppState appReducer(AppState previous, dynamic action) {
  if (action is SetRouteAction && !action.isInitialRoute) {
    return previous.rebuild((builder) {
      builder.routerState.update((builder) {
        switch(action.routerAction){
          case RouterAction.pop:
            builder.routes.remove(builder.routes.last);
            break;
          case RouterAction.push:
            builder.routes.add(RouteState((builder) {
              builder.name = action.payload;
              builder.isInitialRoute = action.isInitialRoute;
            }));
            break;
          case RouterAction.replace:
            builder.routes.remove(builder.routes.last);
            builder.routes.add(RouteState((builder) {
              builder.name = action.payload;
              builder.isInitialRoute = action.isInitialRoute;
            }));
            break;
          case RouterAction.remove:
            throw 'not implemented: ${action.routerAction}';
            break;
        }
        print('${builder.routes.build()}');
      });
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
