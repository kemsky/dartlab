library routes;

import 'package:dart_lab/reflection/reflector.dart';
import 'package:reflectable/reflectable.dart';

@reflector
abstract class Routes {
  static final AppRoute SplashScreen = AppRoute('/');
  static final AppRoute SetupScreen = AppRoute('Setup');
  static final AppRoute AppScreen = AppRoute('Application', defaultUrl: '/Application/Activity');

  static final AppRoute AppActivity = AppRoute.childOf('Activity', AppScreen);
  static final AppRoute AppActivityActivity = AppRoute.childOf('Activity', AppActivity);
  static final AppRoute AppActivityIssues = AppRoute.childOf('Issues', AppActivity);
  static final AppRoute AppActivityMergeRequests = AppRoute.childOf('MergeRequests', AppActivity);
  static final AppRoute AppActivityTodos = AppRoute.childOf('Todos', AppActivity);


  static final AppRoute AppProjects = AppRoute.childOf('Projects', AppScreen);

  static final AppRoute AppAbout = AppRoute.childOf('About', AppScreen);

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

  bool isChildOf(AppRoute parent) {
    return this.url.startsWith(parent.url);
  }

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
    return 'AppRoute{name: $name, route: $route, defaultUrl: $defaultUrl, children: ${children.length}, parent: ${parent?.url}, url: $url}';
  }
}
