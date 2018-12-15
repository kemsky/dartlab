library routes;

import 'package:dart_lab/reflection/reflector.dart';
import 'package:reflectable/reflectable.dart';

@reflector
abstract class Routes {
  static final AppRoute SplashScreen = AppRoute('/');
  static final AppRoute SetupScreen = AppRoute('Setup');
  static final AppRoute ApplicationScreen = AppRoute('Application', defaultUrl: '/Application/Activity');

  static final AppRoute ApplicationActivity = AppRoute.childOf('Activity', ApplicationScreen);
  static final AppRoute ApplicationProjects = AppRoute.childOf('Projects', ApplicationScreen);
  static final AppRoute ApplicationAbout = AppRoute.childOf('About', ApplicationScreen);

  static Map<String, AppRoute> map = new Map<String, AppRoute>();

  static void initialize() {
    //overcome lazy init
    ClassMirror mirror = reflector.reflectType(Routes);
    mirror.staticMembers.forEach((key, method) {
      if (method.isGetter) {
        mirror.invokeGetter(key);
      }
    });

    Routes.map.forEach((url, route) {
      assert (Routes.map.containsKey(route.defaultUrl), 'unknown url: \'${route.defaultUrl}\'');
    });
  }
}

class AppRoute {
  final String name;
  final String route;
  final String defaultUrl;
  final List<String> path;
  final List<AppRoute> children = [];

  String get url => _url;

  bool get isBranch => this.children.length > 0;

  bool get isLeaf => this.children.length == 0;

  AppRoute get parent => _parent;

  AppRoute _parent;

  String _url;

  AppRoute(String name, {String defaultUrl})
      : this.defaultUrl = defaultUrl ?? (name != '/' ? '/' + name : '/'),
        this.name = name,
        this.route = name == '/' ? '/' : ('/' + name),
        this.path = [name] {
    this._url = '/' + (name == '/' ? '' : name);
    Routes.map[this.url] = this;
  }

  AppRoute.childOf(String name, AppRoute parent, {String defaultPath})
      : this.route = parent.route,
        this.name = name,
        this.defaultUrl = [parent.url, name, defaultPath].where((x) => x != null).join('/'),
        this.path = List.of(parent.path) {
    parent.children.add(this);
    this.path.add(this.name);
    this._url = '/' + this.path.join('/');
    this._parent = parent;
    Routes.map[this.url] = this;
  }

  @override
  String toString() {
    return 'RouteElement{name: $name, route: $route, defaultUrl: $defaultUrl, path: $path, children: $children}';
  }
}
