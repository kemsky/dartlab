import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';

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
        builder.packageInfo = action.payload;
      });
    default:
      return previous;
  }
}
