import 'package:dart_lab/home.page.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Application extends StatelessWidget {
  final Store<AppState> store;

  Application(this.store);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
        store: this.store,
        child: new MaterialApp(
          title: 'DartLab',
          theme: new ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: new HomePage(title: 'DartLab'),
        )
    );
  }
}