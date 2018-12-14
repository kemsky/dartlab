abstract class Routes {
  static final String SplashRoute = '/';
  static final String SetupRoute = '/SetupScreen';
  static final String ApplicationRoute = '/ApplicationScreen';
}

class RouteElements {
  static final RouteElement SplashScreen = RouteElement(route: '/', defaultUrl: '/');
  static final RouteElement SetupScreen = RouteElement(route: '/Setup', defaultUrl: '/Setup');
  static final RouteElement ApplicationScreen = RouteElement(route: '/Application', defaultUrl: '/Application/Activity');

  static final RouteElement ApplicationActivity = RouteElement.childOf(ApplicationScreen, path: 'Activity');
  static final RouteElement ApplicationProjects = RouteElement.childOf(ApplicationScreen, path: 'Activity');
  static final RouteElement ApplicationAbout = RouteElement.childOf(ApplicationScreen, path: 'About');


  RouteElements() {

  }
}

class RouteElement {
  final String route;
  final String defaultUrl;
  final List<String> path;
  final List<RouteElement> children = [];

  bool get isBranch => this.children.length > 0;

  bool get isLeaf => this.children.length  == 0;

  RouteElement get parent => _parent;

  RouteElement _parent;

  RouteElement({this.route, this.defaultUrl, this.path = const []});

  RouteElement.childOf(RouteElement parent, {String defaultUrl, String path}) : this.route = parent.route, this.defaultUrl = defaultUrl, this.path = List.of(parent.path) {
    parent.children.add(this);
    this.path.add(path);
    this._parent = parent;
  }
}
