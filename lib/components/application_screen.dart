import 'package:dart_lab/components/application/application_about_view.dart';
import 'package:dart_lab/components/application/application_activity_view.dart';
import 'package:dart_lab/components/application/application_drawer.dart';
import 'package:dart_lab/components/application/application_projects_view.dart';
import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

@immutable
class ApplicationScreen extends StatelessWidget {
  ApplicationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, AppRoute>(
        converter: (store) => store.state.routerState.appRoute,
        builder: (context, currentRoute) {
          Widget body;
          if (currentRoute.isChildOf(Routes.AppActivity)) {
            body = ApplicationActivityView(currentRoute);
          } else if (currentRoute.isChildOf(Routes.AppProjects)) {
            body = ApplicationProjectsView(currentRoute);
          } else if (currentRoute.isChildOf(Routes.AppAbout)) {
            body = ApplicationAboutView(currentRoute);
          } else {
            body = Text('unknown route: ${currentRoute}');
          }
          return new Scaffold(
            drawer: applicationDrawer(currentRoute),
            appBar: new AppBar(
              title: new Text(getTitle(currentRoute)),
              elevation: 0,
            ),
            body: body,
          );
        });
  }

  String getTitle(AppRoute currentRoute) {
    String title;
    if (currentRoute.isChildOf(Routes.ActivityActivity)) {
      title = Routes.ActivityActivity.name;
    } else if (currentRoute.isChildOf(Routes.ActivityIssues)) {
      title = Routes.ActivityIssues.name;
    } else if (currentRoute.isChildOf(Routes.ActivityMergeRequests)) {
      title = Routes.ActivityMergeRequests.name;
    } else if (currentRoute.isChildOf(Routes.ActivityTodos)) {
      title = Routes.ActivityTodos.name;
    } else if (currentRoute.isChildOf(Routes.AppAbout)) {
      title = Routes.AppAbout.name;
    } else {
      title = 'unknown route: ${currentRoute.name}';
    }
    return title;
  }
}
