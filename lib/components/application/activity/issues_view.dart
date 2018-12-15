import 'package:dart_lab/routes.dart';
import 'package:flutter/material.dart';

class IssuesView extends StatelessWidget {
  static final Map<int, AppRoute> TabBarRoutes = {
    0: Routes.IssuesCreated,
    1: Routes.IssuesAssigned,
  };

  final AppRoute currentRoute;

  final List<String> items;

  IssuesView(this.currentRoute) : this.items = List<String>.generate(10000, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${items[index]}'),
        );
      },
    );
  }
}
