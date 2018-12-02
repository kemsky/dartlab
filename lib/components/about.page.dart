import 'package:dart_lab/components/application.drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  AboutPageState createState() => new AboutPageState();
}

class AboutPageState extends State<AboutPage> {

  PackageInfo _packageInfo = new PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: applicationDrawer(),
      appBar: new AppBar(
        title: new Text('About'),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 250,
            decoration: const BoxDecoration(color: Color.fromARGB(255, 240, 240, 240)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  child: Icon(Icons.account_circle),
                  radius: 35,
                ),
                SizedBox(height: 25),
                Text(_packageInfo.appName.toUpperCase(), style: TextStyle(fontSize: 24)),
                Text('${_packageInfo.version} (${_packageInfo.buildNumber})', style: TextStyle(fontSize: 16)),
              ],
            ),
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
