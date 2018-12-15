import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MergeRequestsView extends StatelessWidget {
  final AppRoute currentRoute;

  MergeRequestsView(this.currentRoute);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      initialIndex: this.currentRoute.isChildOf(Routes.MergeRequestsCreated) ? 0 : 1,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Material(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            child: TabBar(
              tabs: [
                GestureDetector(
                    child: Tab(
                      text: Routes.MergeRequestsCreated.name.toUpperCase(),
                    ),
                    onTap: () {
                      StoreProvider.of<AppState>(context).dispatch(new SetRouteAction(Routes.MergeRequestsCreated));
                    }),
                GestureDetector(
                    child: Tab(
                      text: Routes.MergeRequestsAssigned.name.toUpperCase(),
                    ),
                    onTap: () {
                      StoreProvider.of<AppState>(context).dispatch(new SetRouteAction(Routes.MergeRequestsAssigned));
                    }),
              ],
            )),
      ]),
    );
  }
}
