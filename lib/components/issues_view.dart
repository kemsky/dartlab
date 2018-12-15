import 'package:dart_lab/routes.dart';
import 'package:flutter/material.dart';

class IssuesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Material(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            child: TabBar(
              tabs: [
                Tab(
                  text: Routes.IssuesCreated.name.toUpperCase(),
                ),
                Tab(
                  text: Routes.IssuesAssigned.name.toUpperCase(),
                ),
              ],
            )),
        Container()
      ]),
    );
  }
}
