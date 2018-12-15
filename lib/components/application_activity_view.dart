import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

@immutable
class ApplicationActivityView extends StatelessWidget {
  static final Map<int, AppRoute> BottomBarRoutes = {
    0: Routes.ActivityActivity,
    1: Routes.ActivityIssues,
    2: Routes.ActivityMergeRequests,
    3: Routes.ActivityTodos,
  };

  ApplicationActivityView({Key key}) : super(key: key);

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
        bottomNavigationBar: new StoreConnector<AppState, AppRoute>(
            converter: (store) => store.state.routerState.appRoute,
            builder: (context, currentRoute) {
              int currentIndex = -1;
              BottomBarRoutes.forEach((index, appRoute) {
                if (currentRoute.isChildOf(appRoute)) {
                  currentIndex = index;
                }
              });
              return new BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: currentIndex,
                  onTap: (index) {
                    StoreProvider.of<AppState>(context).dispatch(new SetRouteAction(BottomBarRoutes[index]));
                  },
                  items: [
                    new BottomNavigationBarItem(
                      icon: new Icon(Icons.home),
                      title: new Text(Routes.ActivityActivity.name),
                    ),
                    new BottomNavigationBarItem(
                      icon: new Icon(Icons.build),
                      title: new Text(Routes.ActivityIssues.name),
                    ),
                    new BottomNavigationBarItem(
                      icon: new Icon(Icons.store),
                      title: new Text(Routes.ActivityMergeRequests.name),
                    ),
                    new BottomNavigationBarItem(
                      icon: new Icon(Icons.title),
                      title: new Text(Routes.ActivityTodos.name),
                    )
                  ]);
            }));
  }
}
