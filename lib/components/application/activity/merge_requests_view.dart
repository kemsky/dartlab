import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MergeRequestsView extends StatelessWidget {
  static final Map<int, AppRoute> TabBarRoutes = {
    0: Routes.MergeRequestsCreated,
    1: Routes.MergeRequestsAssigned,
  };

  final AppRoute currentRoute;

  MergeRequestsView(this.currentRoute);

  @override
  Widget build(BuildContext context) {
    final controller = TabController(length: 2, vsync: Scaffold.of(context));

    controller.index = this.currentRoute.isChildOf(Routes.MergeRequestsCreated) ? 0 : 1;

    controller.addListener(() {
      if (controller.indexIsChanging) {
        StoreProvider.of<AppState>(context).dispatch(new SetRouteAction(TabBarRoutes[controller.index]));
      }
    });

    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Material(
          elevation: 5,
          color: Theme.of(context).primaryColor,
          child: TabBar(
            controller: controller,
            tabs: [
              Tab(
                text: Routes.MergeRequestsCreated.name.toUpperCase(),
              ),
              Tab(
                text: Routes.MergeRequestsAssigned.name.toUpperCase(),
              ),
            ],
          )),
    ]);
  }
}
