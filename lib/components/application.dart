import 'package:dart_lab/components/application_screen.dart';
import 'package:dart_lab/components/setup_screen.dart';
import 'package:dart_lab/components/splash_screen.dart';
import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class ApplicationStoreProvider extends StatelessWidget {
  final Store<AppState> store;

  final RouteObserver observer;

  ApplicationStoreProvider(this.store): this.observer = RouteObserver(store);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
        store: this.store, child: new Application(observer));
  }
}

class Application extends StatelessWidget {
  final RouteObserver observer;

  Application(this.observer);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, RouterState>(
        converter: (store) => store.state.routerState,
        builder: (context, router) {
          return new MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DartLab',
            theme: new ThemeData(
              primarySwatch: Colors.deepPurple,
              // Define the default Brightness and Colors
              brightness: Brightness.light,
              primaryColor: Colors.deepPurple,
              accentColor: Colors.orangeAccent,
              buttonColor: Colors.deepPurple,
              // Define the default Font Family
              fontFamily: 'Montserrat',

              // Define the default TextTheme. Use this to specify the default
              // text styling for headlines, titles, bodies of text, and more.
              textTheme: TextTheme(
                headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
              ),
              buttonTheme: ButtonThemeData(
                buttonColor: Colors.deepPurple,
                splashColor: Colors.orangeAccent,
                highlightColor: Colors.blue,
                textTheme: ButtonTextTheme.primary
              )
            ),
            navigatorObservers: [this.observer],
            navigatorKey: navigatorKey,
            routes: <String, WidgetBuilder>{
              Routes.SplashRoute: (BuildContext context) => new SplashScreen(),
              Routes.SetupRoute: (BuildContext context) => new SetupScreen(),
              Routes.ApplicationRoute: (BuildContext context) => new ApplicationScreen(),
            },
            initialRoute: router.route,
          );
        });
  }
}

class RouteObserver extends NavigatorObserver
{
  final Logger logger = new Logger('RouteObserver');

  final Store<AppState> store;

  RouteObserver(this.store);

  @override
  void didPop(Route route, Route previousRoute) {
    this.logger.info('screen didPop: $route ${route.settings.isInitialRoute}');
    this.store.dispatch(SetScreenAction(route.settings.name, NavigatorAction.pop , isInitialRoute: route.settings.isInitialRoute, sync: false));
  }

  @override
  void didPush(Route route, Route previousRoute) {
    this.logger.info('screen didPush: $route ${route.settings.isInitialRoute}');
    this.store.dispatch(SetScreenAction(route.settings.name, NavigatorAction.push, isInitialRoute: route.settings.isInitialRoute, sync: false));
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    this.logger.info('screen didRemove: $route ${route.settings.isInitialRoute}');
    this.store.dispatch(SetScreenAction(route.settings.name, NavigatorAction.remove, isInitialRoute: route.settings.isInitialRoute, sync: false));
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    this.logger.info('screen didReplace: $newRoute ${newRoute.settings.isInitialRoute}');
    this.store.dispatch(SetScreenAction(newRoute.settings.name, NavigatorAction.replace, isInitialRoute: newRoute.settings.isInitialRoute, sync: false));
  }

  @override
  void didStartUserGesture(Route route, Route previousRoute) {
    //nothing
  }

  @override
  void didStopUserGesture() {
    //nothing
  }

  @override
  NavigatorState get navigator => _navigator;

  NavigatorState _navigator;
}
