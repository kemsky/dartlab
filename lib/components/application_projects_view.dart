import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

@immutable
class ApplicationProjectsView extends StatelessWidget {
  final AppRoute currentRoute;

  ApplicationProjectsView(this.currentRoute, {Key key}) : super(key: key);

  void onButtonPress(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(getCurrentUserAction);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return new Text(
                    'Projects!',
                    style: Theme.of(context).textTheme.display1,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => onButtonPress(context),
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
