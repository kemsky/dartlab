import 'package:flutter/material.dart';

class SetupScreen extends StatelessWidget {
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
                child: Icon(Icons.account_circle),
                radius: 35,
              ),
              SizedBox(height: 48.0),
              new Center(child: new Text('D A R T L A B', style: new TextStyle(fontSize: 36, fontWeight: FontWeight.bold))),
            ]),
            SizedBox(height: 8.0),
            new Center(child: new Text('Welcome', style: new TextStyle(fontSize: 26, fontWeight: FontWeight.bold))),
            SizedBox(height: 48.0),
            TextFormField(
              keyboardType: TextInputType.url,
              autofocus: false,
              initialValue: 'https://lab.itmint.ca',
              decoration: InputDecoration(
                hintText: 'URL (e.g. https://gitlab.com)',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              autofocus: false,
              initialValue: null,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Personal Access Token',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              ),
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                onPressed: () {},
                child: new Text("LOGIN"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
