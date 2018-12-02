import 'package:dart_lab/actions.dart';
import 'package:dart_lab/state.dart';

AppState appReducer(AppState previous, dynamic action) {
  switch (action.type) {
    case Actions.INCREMENT:
      return new AppState(previous.counter + 1, previous.currentUser);
    case Actions.DECREMENT:
      return new AppState(previous.counter - 1, previous.currentUser);
    case Actions.SET_CURRENT_USER:
      return new AppState(previous.counter, action.payload);
    default:
      return previous;
  }
}
