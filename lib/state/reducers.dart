import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';

AppState appReducer(AppState previous, dynamic action) {
  switch (action.type) {
    case Actions.INCREMENT:
      return previous.clone(counter: previous.counter + 1);
    case Actions.DECREMENT:
      return previous.clone(counter: previous.counter - 1);
    case Actions.SET_CURRENT_USER:
      return previous.clone(counter: previous.counter + 1, currentUser: action.payload);
    case Actions.SET_PACKAGE_INFO:
      return previous.clone(counter: previous.counter + 1, packageInfo: action.payload);
    default:
      return previous;
  }
}
