import 'package:dart_lab/actions.dart';
import 'package:dart_lab/state.dart';

AppState appReducer(AppState previous, dynamic action) {
  switch (action.type) {
    case Actions.increment:
      return new AppState(previous.counter + 1);
    case Actions.decrement:
      return new AppState(previous.counter - 1);
    default:
      return previous;
  }
}
