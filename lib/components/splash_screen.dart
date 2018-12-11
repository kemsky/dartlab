import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: new Text('D A R T L A B', style: new TextStyle(fontSize: 36, fontWeight: FontWeight.bold))
      ),
    );
  }
}