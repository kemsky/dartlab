import 'package:dart_lab/components/application/activity/activity_view.dart';
import 'package:dart_lab/components/application/activity/issues_view.dart';
import 'package:dart_lab/components/application/activity/merge_requests_view.dart';
import 'package:dart_lab/components/application/activity/todos_view.dart';
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

  final AppRoute currentRoute;

  ApplicationActivityView(this.currentRoute, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (currentRoute.isChildOf(Routes.ActivityActivity)) {
      body = ActivityView(currentRoute);
    } else if (currentRoute.isChildOf(Routes.ActivityIssues)) {
      body = IssuesView(currentRoute);
    } else if (currentRoute.isChildOf(Routes.ActivityMergeRequests)) {
      body = MergeRequestsView(currentRoute);
    } else if (currentRoute.isChildOf(Routes.ActivityTodos)) {
      body = TodosView(currentRoute);
    } else {
      body = Text('unknown route: $currentRoute');
    }

    int bottomBarIndex = -1;

    BottomBarRoutes.forEach((index, appRoute) {
      if (currentRoute.isChildOf(appRoute)) {
        bottomBarIndex = index;
      }
    });

    return new Scaffold(
        body: body,
        // This trailing comma makes
        bottomNavigationBar: new BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: bottomBarIndex,
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
            ]));
  }
}
