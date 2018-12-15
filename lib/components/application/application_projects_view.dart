import 'package:dart_lab/components/application/projects/all_projects_view.dart';
import 'package:dart_lab/components/application/projects/my_projects_view.dart';
import 'package:dart_lab/components/application/projects/starred_projects_view.dart';
import 'package:dart_lab/routes.dart';
import 'package:flutter/material.dart';

@immutable
class ApplicationProjectsView extends StatelessWidget {
  final AppRoute currentRoute;

  ApplicationProjectsView(this.currentRoute, {Key key}) : super(key: key);

  void onButtonPress(BuildContext context) {
    //StoreProvider.of<AppState>(context).dispatch(getCurrentUserAction);
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (currentRoute.isChildOf(Routes.ProjectsAll)) {
      body = AllProjectsView(currentRoute);
    } else if (currentRoute.isChildOf(Routes.ProjectsMy)) {
      body = MyProjectsView(currentRoute);
    } else if (currentRoute.isChildOf(Routes.ProjectsStarred)) {
      body = StarredProjectsView(currentRoute);
    } else {
      body = Text('unknown route: $currentRoute');
    }

    return new Scaffold(
      body: body,
    );
  }
}
