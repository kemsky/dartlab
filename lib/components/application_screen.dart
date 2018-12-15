import 'package:dart_lab/components/application/application_about_view.dart';
import 'package:dart_lab/components/application/application_activity_view.dart';
import 'package:dart_lab/components/application/application_drawer.dart';
import 'package:dart_lab/components/application/application_projects_view.dart';
import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tuple/tuple.dart';

class ApplicationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApplicationScreen();
  }
}

class _ApplicationScreen extends State<ApplicationScreen> with TickerProviderStateMixin {
  _ApplicationScreen() : super();

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

          final appBarOptions = getBottom(currentRoute, context);

          return Scaffold(
            drawer: applicationDrawer(currentRoute),
            appBar: AppBar(
              title: Text(appBarOptions.item2),
              bottom: appBarOptions.item1,
            ),
            body: body,
          );
        });
  }

  Tuple2<Widget, String> getBottom(AppRoute currentRoute, BuildContext context) {
    AppRoute route;
    String title = 'unknown: ${currentRoute.name}';
    if (currentRoute.isChildOf(Routes.ActivityIssues)) {
      route = Routes.ActivityIssues;
    } else if (currentRoute.isChildOf(Routes.ActivityMergeRequests)) {
      route = Routes.ActivityMergeRequests;
    } else if (currentRoute.isChildOf(Routes.ActivityTodos)) {
      route = Routes.ActivityTodos;
    } else if (currentRoute.isChildOf(Routes.ActivityActivity)) {
      return Tuple2(null, Routes.ActivityActivity.name);
    } else {
      return Tuple2(null, title);
    }

    final children = route.children;

    final controller = TabController(length: children.length, vsync: this);

    controller.index = route.children.indexWhere((appRoute) => currentRoute.isChildOf(appRoute));

    controller.addListener(() {
      if (controller.indexIsChanging) {
        StoreProvider.of<AppState>(context).dispatch(new SetRouteAction(children[controller.index]));
      }
    });

    return Tuple2(TabBar(controller: controller, tabs: children.map((route) => Tab(text: route.name.toUpperCase())).toList()), route.name);
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
