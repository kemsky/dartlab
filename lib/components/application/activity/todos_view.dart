import 'package:dart_lab/routes.dart';
import 'package:flutter/material.dart';

class TodosView extends StatelessWidget {
  final AppRoute currentRoute;

  TodosView(this.currentRoute);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Material(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            child: TabBar(
              tabs: [
                Tab(
                  text: Routes.TodosPending.name.toUpperCase(),
                ),
                Tab(
                  text: Routes.TodosDone.name.toUpperCase(),
                ),
              ],
            )),
        Container()
      ]),
    );
  }
}
