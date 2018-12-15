import 'package:dart_lab/components/application_drawer.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

@immutable
class ApplicationActivityView extends StatelessWidget {
  ApplicationActivityView({Key key}) : super(key: key);

  void onButtonPress(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(getCurrentUserAction);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: applicationDrawer(),
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text('Activity'),
        ),
        body: new Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: new Column(
            // Column is also layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug paint" (press "p" in the console where you ran
            // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
            // window in IntelliJ) to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (context, state) {
                    return new Text(
                      'Activity!',
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
        // This trailing comma makes
        bottomNavigationBar: new BottomNavigationBar(items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home, color: Colors.deepPurple),
            title: new Text("Activity", style: TextStyle(color: Colors.deepPurple)),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.build, color: Colors.deepPurple),
            title: new Text("Issues", style: TextStyle(color: Colors.deepPurple)),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.store, color: Colors.deepPurple),
            title: new Text("Merge Requests", style: TextStyle(color: Colors.deepPurple)),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.title, color: Colors.deepPurple),
            title: new Text("Todos", style: TextStyle(color: Colors.deepPurple)),
          )
        ]) // auto-formatting nicer for build methods.
        );
  }
}
