import 'package:flutter/material.dart';

class SetupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: new Text('setup', style: new TextStyle(fontSize: 36, fontWeight: FontWeight.bold))
      ),
    );
  }
}