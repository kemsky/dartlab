import 'package:dart_lab/routes.dart';
import 'package:flutter/material.dart';

class StarredProjectsView extends StatelessWidget {
  final AppRoute currentRoute;

  final List<String> items;

  StarredProjectsView(this.currentRoute) : this.items = List<String>.generate(10000, (i) => "Item $i");

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
