import 'package:dart_lab/components/about_page.dart';
import 'package:dart_lab/components/home_page.dart';
import 'package:dart_lab/components/splash_screen.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class ApplicationStoreProvider extends StatelessWidget {
  final Store<AppState> store;

  ApplicationStoreProvider(this.store);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
        store: this.store, child: new Application());
  }
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, String>(
        converter: (store) => store.state.route,
        builder: (context, route) {
          return new MaterialApp(
            title: 'DartLab',
            theme: new ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            navigatorKey: navigatorKey,
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) => new SplashScreen(),
              '/HomePage': (BuildContext context) => new HomePage(),
              '/AboutPage': (BuildContext context) => new AboutPage()
            },
            initialRoute: route,
            onGenerateRoute: (route) => _onGenerateRoute(route, context),
          );
        });
  }

  _onGenerateRoute(RouteSettings route, BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(SetRouteAction(route.name, sync: false));
  }
}
