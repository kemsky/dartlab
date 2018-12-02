enum Actions {
  increment,
  decrement,
}

abstract class Action<T, P> {
  final T type;
  final P payload;

  Action(this.type, {this.payload});

  @override
  String toString()
  {
    return 'Action{type: $type, payload: $payload}';
  }
}

class IncrementAction extends Action<Actions, void> {
  IncrementAction() : super(Actions.increment);
}

class DecrementAction extends Action<Actions, void> {
  DecrementAction() : super(Actions.decrement);
}
