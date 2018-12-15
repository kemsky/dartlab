import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SetupScreen extends StatefulWidget {
  final String host;

  final String token;

  @override
  State<StatefulWidget> createState() {
    return _SetupScreen(this.host, this.token);
  }

  SetupScreen(this.host, this.token);
}

class _SetupScreen extends State<SetupScreen> {
  String _host;
  String _token;

  _SetupScreen(this._host, this._token);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
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
                    initialValue: state.host,
                    decoration: InputDecoration(
                      hintText: 'URL (e.g. https://gitlab.com)',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    ),
                    onSaved: (_) => _host = _,
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    autofocus: false,
                    initialValue: state.token,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Personal Access Token',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    ),
                    onSaved: (_) => _token = _,
                  ),
                  SizedBox(height: 24.0),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Builder(builder: (BuildContext context) {
                      return RaisedButton(
                        padding: const EdgeInsets.all(8.0),
                        onPressed: () {
                          StoreProvider.of<AppState>(context).dispatch(loginUser(_host, _token, context));
                        },
                        child: Text("LOGIN"),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
