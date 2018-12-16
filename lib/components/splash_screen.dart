import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Column(children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/logo.png'),
                radius: 35,
              ),
              SizedBox(height: 48.0),
              new Center(child: new Text('D A R T L A B', style: new TextStyle(fontSize: 36, fontWeight: FontWeight.bold))),
            ])
          ],
        ),
      ),
    );
  }
}
