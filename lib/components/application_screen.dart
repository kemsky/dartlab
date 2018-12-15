import 'package:dart_lab/components/application_about_view.dart';
import 'package:dart_lab/components/application_activity_view.dart';
import 'package:dart_lab/components/application_drawer.dart';
import 'package:dart_lab/components/application_projects_view.dart';
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
        builder: (context, appRoute) {
          Widget widget;
          if (appRoute.isChildOf(Routes.AppActivity)) {
            widget = ApplicationActivityView();
          } else if (appRoute.isChildOf(Routes.AppProjects)) {
            widget = ApplicationProjectsView();
          } else if (appRoute.isChildOf(Routes.AppAbout)) {
            widget = ApplicationAboutView();
          } else {
            widget = Text('unknown route: ${appRoute}');
          }
          return new Scaffold(
            drawer: applicationDrawer(),
            appBar: new AppBar(
              title: new Text(appRoute.name),
              elevation: 0,
            ),
            body: widget,
          );
        });
  }
}
