import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';

AppState appReducer(AppState previous, dynamic action) {
  if (action is IncrementAction) {
    return previous.rebuild((builder) {
      builder.counter = builder.counter + 1;
    });
  } else if (action is DecrementAction) {
    return previous.rebuild((builder) {
      builder.counter = builder.counter - 1;
    });
  } else if (action is SetCurrentUserAction) {
    return previous.rebuild((builder) {
      builder.counter = builder.counter + 1;
      builder.currentUser.replace(action.payload);
    });
  } else if (action is SetPackageInfoAction) {
    return previous.rebuild((builder) {
      builder.counter = builder.counter + 1;
      builder.appName = action.payload.appName;
      builder.buildNumber = action.payload.buildNumber;
      builder.version = action.payload.version;
      builder.packageName = action.payload.packageName;
    });
  } else {
    return previous;
  }
}
