import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class TodosView extends StatelessWidget {
  static final Map<int, AppRoute> TabBarRoutes = {
    0: Routes.TodosPending,
    1: Routes.TodosDone,
  };

  final AppRoute currentRoute;

  TodosView(this.currentRoute);

  @override
  Widget build(BuildContext context) {
    final controller = TabController(length: 2, vsync: Scaffold.of(context));

    controller.addListener(() {
      if (controller.indexIsChanging) {
        StoreProvider.of<AppState>(context).dispatch(new SetRouteAction(TabBarRoutes[controller.index]));
      }
    });

    return new DefaultTabController(
      length: 2,
      initialIndex: this.currentRoute.isChildOf(Routes.TodosDone) ? 0 : 1,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Material(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            child: TabBar(
              controller: controller,
              tabs: [
                Tab(
                  text: Routes.TodosPending.name.toUpperCase(),
                ),
                Tab(
                  text: Routes.TodosDone.name.toUpperCase(),
                ),
              ],
            )),
      ]),
    );
  }
}
