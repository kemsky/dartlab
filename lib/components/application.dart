import 'package:dart_lab/components/application_screen.dart';
import 'package:dart_lab/components/setup_screen.dart';
import 'package:dart_lab/components/splash_screen.dart';
import 'package:dart_lab/screens.dart';
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
    return new StoreConnector<AppState, ScreensState>(
        converter: (store) => store.state.screenState,
        builder: (context, router) {
          return new MaterialApp(
            title: 'DartLab',
            theme: new ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            navigatorObservers: [this.observer],
            navigatorKey: navigatorKey,
            routes: <String, WidgetBuilder>{
              Screens.SplashScreen: (BuildContext context) => new SplashScreen(),
              Screens.SetupScreen: (BuildContext context) => new SetupScreen(),
              Screens.ApplicationScreen: (BuildContext context) => new ApplicationScreen(),
            },
            initialRoute: router.currentScreen.name,
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
    this.store.dispatch(SetScreenAction(route.settings.name, ScreenAction.pop , isInitialScreen: route.settings.isInitialRoute, sync: false));
  }

  @override
  void didPush(Route route, Route previousRoute) {
    this.logger.info('screen didPush: $route ${route.settings.isInitialRoute}');
    this.store.dispatch(SetScreenAction(route.settings.name, ScreenAction.push, isInitialScreen: route.settings.isInitialRoute, sync: false));
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    this.logger.info('screen didRemove: $route ${route.settings.isInitialRoute}');
    this.store.dispatch(SetScreenAction(route.settings.name, ScreenAction.remove, isInitialScreen: route.settings.isInitialRoute, sync: false));
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    this.logger.info('screen didReplace: $newRoute ${newRoute.settings.isInitialRoute}');
    this.store.dispatch(SetScreenAction(newRoute.settings.name, ScreenAction.replace, isInitialScreen: newRoute.settings.isInitialRoute, sync: false));
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
