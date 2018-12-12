library reducers;

import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';

AppState appReducer(AppState previous, dynamic action) {
  if (action is SetScreenAction && !action.isInitialScreen) {
    return previous.rebuild((builder) {
      builder.screenState.update((builder) {
        switch(action.screenAction){
          case ScreenAction.pop:
            builder.screens.remove(builder.screens.last);
            break;
          case ScreenAction.push:
            builder.screens.add(ScreenState((builder) {
              builder.name = action.screen;
              builder.isInitialScreen = action.isInitialScreen;
            }));
            break;
          case ScreenAction.replace:
            builder.screens.remove(builder.screens.last);
            builder.screens.add(ScreenState((builder) {
              builder.name = action.screen;
              builder.isInitialScreen = action.isInitialScreen;
            }));
            break;
          case ScreenAction.remove:
            throw 'not implemented: ${action.screenAction}';
            break;
        }
        print('${builder.screens.build()}');
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
