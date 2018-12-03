import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';

AppState appReducer(AppState previous, dynamic action) {
  switch (action.type) {
    case Actions.INCREMENT:
      return new AppState(previous.counter + 1, previous.currentUser, previous.title, previous.packageInfo);
    case Actions.DECREMENT:
      return new AppState(previous.counter - 1, previous.currentUser, previous.title, previous.packageInfo);
    case Actions.SET_CURRENT_USER:
      return new AppState(previous.counter + 1, action.payload, previous.title, previous.packageInfo);
    case Actions.SET_PACKAGE_INFO:
      return new AppState(previous.counter + 1, previous.currentUser, previous.title, action.payload);
    default:
      return previous;
  }
}
