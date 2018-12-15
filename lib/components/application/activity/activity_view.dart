import 'package:dart_lab/routes.dart';
import 'package:flutter/material.dart';

class ActivityView extends StatelessWidget {
  final AppRoute currentRoute;

  ActivityView(this.currentRoute);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[Text('Issues')],
    );
  }
}
