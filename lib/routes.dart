library routes;

abstract class Routes {
  static final AppRoute SplashScreen = AppRoute('/');
  static final AppRoute SetupScreen = AppRoute('Setup');
  static final AppRoute ApplicationScreen = AppRoute('Application', defaultUrl: '/Application/Activity');

  static final AppRoute ApplicationActivity = AppRoute.childOf('Activity', ApplicationScreen);
  static final AppRoute ApplicationProjects = AppRoute.childOf('Projects', ApplicationScreen);
  static final AppRoute ApplicationAbout = AppRoute.childOf('About', ApplicationScreen);

  static Map<String, AppRoute> get map => _routes;
  static final Map<String, AppRoute> _routes = new Map<String, AppRoute>();
}

class AppRoute {
  final String name;
  final String route;
  final String defaultUrl;
  final List<String> path;
  final List<AppRoute> children = [];

  String get url => _url;

  bool get isBranch => this.children.length > 0;

  bool get isLeaf => this.children.length  == 0;

  AppRoute get parent => _parent;

  AppRoute _parent;

  String _url;

  AppRoute(String name, {String defaultUrl}) : this.defaultUrl = defaultUrl ?? (name != '/' ? '/' + name : '/'), this.name = name, this.route = name == '/' ? '/' : ('/' + name), this.path = [name] {
    var key = '/' + (name == '/' ? '' : name);
    Routes.map[key] = this;
    print('key: $key');
  }

  AppRoute.childOf(this.name, AppRoute parent, {String defaultPath}) : this.route = parent.route, this.defaultUrl = [parent.url, name, defaultPath].where((x) => x != null).join('/'), this.path = List.of(parent.path) {
    parent.children.add(this);
    this.path.add(this.name);
    this._url = '/' + this.path.join('/');
    this._parent = parent;
    var key = this._url;
    Routes.map[key] = this;
    print('key: $key');
  }

  @override
  String toString() {
    return 'RouteElement{name: $name, route: $route, defaultUrl: $defaultUrl, path: $path, children: $children}';
  }
}
