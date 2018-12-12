import 'package:dart_lab/components/about_page.dart';
import 'package:dart_lab/components/home_page.dart';
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
            title: 'DartLab',
            theme: new ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            navigatorObservers: [this.observer],
            navigatorKey: navigatorKey,
            routes: <String, WidgetBuilder>{
              Routes.Splash: (BuildContext context) => new SplashScreen(),
              Routes.Activity: (BuildContext context) => new HomePage(),
              Routes.About: (BuildContext context) => new AboutPage()
            },
            initialRoute: router.currentRoute.name,
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
    this.logger.info('didPop: $route ${route.settings.isInitialRoute}');
    this.store.dispatch(SetRouteAction(route.settings.name, RouterAction.pop , isInitialRoute: route.settings.isInitialRoute, sync: false));
  }

  @override
  void didPush(Route route, Route previousRoute) {
    this.logger.info('route: $route ${route.settings.isInitialRoute}');
    this.store.dispatch(SetRouteAction(route.settings.name, RouterAction.push, isInitialRoute: route.settings.isInitialRoute, sync: false));
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    this.logger.info('didRemove: $route ${route.settings.isInitialRoute}');
    this.store.dispatch(SetRouteAction(route.settings.name, RouterAction.remove, isInitialRoute: route.settings.isInitialRoute, sync: false));
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    this.logger.info('didReplace: $newRoute ${newRoute.settings.isInitialRoute}');
    this.store.dispatch(SetRouteAction(newRoute.settings.name, RouterAction.replace, isInitialRoute: newRoute.settings.isInitialRoute, sync: false));
  }

  @override
  void didStartUserGesture(Route route, Route previousRoute) {
    this.logger.info('didStartUserGesture: $route');
  }

  @override
  void didStopUserGesture() {
    this.logger.info('didStopUserGesture');
  }

  @override
  NavigatorState get navigator => _navigator;

  NavigatorState _navigator;
}
