import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:dart_lab/webapi/model/gitlab_current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

StoreConnector<AppState, GitLabCurrentUser> applicationDrawer() {
  return new StoreConnector<AppState, GitLabCurrentUser>(
      converter: (store) => store.state.currentUser,
      builder: (context, state) {
        return Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the Drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    currentAccountPicture: new CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      backgroundImage: NetworkImage(state?.avatar_url ?? ''),
                    ),
                    accountName: Text(state?.name ?? '',
                        style: TextStyle(color: Colors.white)),
                    accountEmail: Text(state?.email ?? '',
                        style: TextStyle(color: Colors.white)),
                  ),
                  new Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 16),
                        child: IconButton(
                        icon: Icon(Icons.exit_to_app),
                        color: Colors.white,
                        onPressed: () {}
                        )),
                  )
                ],
              ),
              ListTile(
                leading: const Icon(Icons.assessment, color: Colors.black),
                title: Text('Activity',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context);
                  StoreProvider.of<AppState>(context).dispatch(SetRouteAction(Routes.Activity, RouterAction.replace));
                },
              ),
              ListTile(
                leading: const Icon(Icons.format_list_bulleted, color: Colors.black),
                title: Text('Projects',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  // Update the state of the app
                  // ...
                },
              ),
              Divider(),
              ListTile(
                leading: const Icon(Icons.info, color: Colors.black),
                title: Text('About',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context);
                  StoreProvider.of<AppState>(context).dispatch(SetRouteAction(Routes.About, RouterAction.push));
                },
              ),
            ],
          ),
        );
      });
}
