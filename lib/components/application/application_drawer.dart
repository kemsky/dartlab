import 'package:dart_lab/database/model/application_user.dart';
import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

StoreConnector<AppState, ApplicationUser> applicationDrawer(AppRoute currentRoute) {
  return new StoreConnector<AppState, ApplicationUser>(
      converter: (store) => store.state.applicationUser,
      builder: (context, applicationUser) {
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
                      backgroundImage: NetworkImage(applicationUser?.avatarUrl ?? ''),
                    ),
                    accountName: Text(applicationUser?.fullName ?? '', style: TextStyle(color: Colors.white)),
                    accountEmail: Text(applicationUser?.email ?? '', style: TextStyle(color: Colors.white)),
                  ),
                  new Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: IconButton(
                            icon: Icon(Icons.exit_to_app),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                              StoreProvider.of<AppState>(context).dispatch(new SetRouteAction(Routes.SetupScreen, drawer: true));
                            })),
                  )
                ],
              ),
              Container(
                  decoration: new BoxDecoration(color: currentRoute.isChildOf(Routes.AppActivity) ? Theme.of(context).selectedRowColor : Theme.of(context).scaffoldBackgroundColor),
                  child: ListTile(
                    leading: const Icon(Icons.assessment, color: Colors.black),
                    title: Text('Activity', style: TextStyle(fontWeight: FontWeight.bold)),
                    selected: currentRoute.url.startsWith(Routes.AppActivity.url),
                    onTap: () {
                      Navigator.pop(context);
                      StoreProvider.of<AppState>(context).dispatch(new SetRouteAction(Routes.AppActivity, drawer: true));
                    },
                  )),
              Container(
                  decoration: new BoxDecoration(color: currentRoute.isChildOf(Routes.AppProjects) ? Theme.of(context).selectedRowColor : Theme.of(context).scaffoldBackgroundColor),
                  child: ListTile(
                    leading: const Icon(Icons.format_list_bulleted, color: Colors.black),
                    title: Text('Projects', style: TextStyle(fontWeight: FontWeight.bold)),
                    selected: currentRoute.url.startsWith(Routes.AppProjects.url),
                    onTap: () {
                      Navigator.pop(context);
                      StoreProvider.of<AppState>(context).dispatch(new SetRouteAction(Routes.AppProjects, drawer: true));
                    },
                  )),
              Divider(),
              Container(
                decoration: new BoxDecoration(color: currentRoute == Routes.AppAbout ? Theme.of(context).selectedRowColor : Theme.of(context).scaffoldBackgroundColor),
                child: ListTile(
                  leading: const Icon(Icons.info, color: Colors.black),
                  title: Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
                  selected: currentRoute == Routes.AppAbout,
                  onTap: () {
                    Navigator.pop(context);
                    StoreProvider.of<AppState>(context).dispatch(new SetRouteAction(Routes.AppAbout, drawer: true));
                  },
                ),
              ),
            ],
          ),
        );
      });
}
