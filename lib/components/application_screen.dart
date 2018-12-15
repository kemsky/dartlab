import 'package:dart_lab/components/application_about_view.dart';
import 'package:dart_lab/components/application_activity_view.dart';
import 'package:dart_lab/components/application_projects_view.dart';
import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logging/logging.dart';

@immutable
class ApplicationScreen extends StatelessWidget {
  static final Logger _logger = Logger('ApplicationScreen');

  ApplicationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, RouterState>(
        converter: (store) => store.state.routerState,
        builder: (context, routerState) {
          if (routerState.appRoute.isChildOf(Routes.AppActivity)) {
            return ApplicationActivityView();
          } else if (routerState.appRoute.isChildOf(Routes.AppProjects)) {
            return ApplicationProjectsView();
          } else if (routerState.appRoute.isChildOf(Routes.AppAbout)) {
            return ApplicationAboutView();
          } else {
            _logger.info('unknown route: ${routerState.appRoute}');
            return Container();
          }
        });
  }
}
