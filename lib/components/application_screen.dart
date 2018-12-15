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
          Widget widget;
          if (currentRoute.isChildOf(Routes.AppActivity)) {
            widget = ApplicationActivityView(currentRoute);
          } else if (currentRoute.isChildOf(Routes.AppProjects)) {
            widget = ApplicationProjectsView(currentRoute);
          } else if (currentRoute.isChildOf(Routes.AppAbout)) {
            widget = ApplicationAboutView(currentRoute);
          } else {
            widget = Text('unknown route: ${currentRoute}');
          }
          return new Scaffold(
            drawer: applicationDrawer(currentRoute),
            appBar: new AppBar(
              title: new Text(currentRoute.name),
              elevation: 0,
            ),
            body: widget,
          );
        });
  }
}
