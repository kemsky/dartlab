import 'package:dart_lab/webapi/model/current.user.dart';
import 'package:flutter/material.dart';

Drawer createDrawer(CurrentUser state) {
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the Drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(state?.name ?? '', style: TextStyle(color: Colors.white)),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
          ),
        ),
        ListTile(
          title: Text('Item 1'),
          onTap: () {
            // Update the state of the app
            // ...
          },
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: () {
            // Update the state of the app
            // ...
          },
        ),
      ],
    ),
  );
}
