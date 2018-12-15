import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:url_launcher/url_launcher.dart';

@immutable
class ApplicationAboutView extends StatelessWidget {
  final AppRoute currentRoute;

  ApplicationAboutView(this.currentRoute, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 250,
            decoration: const BoxDecoration(color: Color.fromARGB(255, 240, 240, 240)),
            child: new StoreConnector<AppState, ApplicationInfo>(
                converter: (store) => store.state.applicationInfo,
                builder: (context, packageInfo) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        child: Icon(Icons.account_circle),
                        radius: 35,
                      ),
                      SizedBox(height: 25),
                      Text(packageInfo.appName.toUpperCase(), style: TextStyle(fontSize: 24)),
                      Text('${packageInfo.version} (${packageInfo.buildNumber})', style: TextStyle(fontSize: 16)),
                    ],
                  );
                }),
          ),
          ListTile(
            title: Text('Info', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.comment, color: Colors.black),
            title: Text('Write feedback', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.library_books, color: Colors.black),
            title: Text('Open Source Libraries', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.format_align_left, color: Colors.black),
            title: Text('Privacy policy', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {},
          ),
          ListTile(
            title: Text('Authors', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage('https://avatars1.githubusercontent.com/u/3826972?s=60&v=4'),
              radius: 25,
            ),
            title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Alexander Turtsevich', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('main developer', style: TextStyle())
                ]),
            onTap: () {
              launch('https://github.com/kemsky/');
            },
          )
        ],
      ),
    );
  }
}
