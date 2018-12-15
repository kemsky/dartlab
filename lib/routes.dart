library routes;

import 'package:dart_lab/reflection/reflector.dart';
import 'package:reflectable/reflectable.dart';

@reflector
abstract class Routes {
  static final AppRoute SplashScreen = AppRoute('/');
  static final AppRoute SetupScreen = AppRoute('Setup');
  static final AppRoute AppScreen = AppRoute('Application', defaultUrl: '/Application/Activity/Activity');

  static final AppRoute AppActivity = AppRoute.childOf('Activity', AppScreen, defaultPath: 'Activity');

  static final AppRoute ActivityActivity = AppRoute.childOf('Activity', AppActivity);
  static final AppRoute ActivityIssues = AppRoute.childOf('Issues', AppActivity, defaultPath: 'Created');
  static final AppRoute IssuesCreated = AppRoute.childOf('Created', ActivityIssues);
  static final AppRoute IssuesAssigned = AppRoute.childOf('Assigned', ActivityIssues);
  static final AppRoute ActivityMergeRequests = AppRoute.childOf('Merge Requests', AppActivity, defaultPath: 'Created');
  static final AppRoute MergeRequestsCreated = AppRoute.childOf('Created', ActivityMergeRequests);
  static final AppRoute MergeRequestsAssigned = AppRoute.childOf('Assigned', ActivityMergeRequests);
  static final AppRoute ActivityTodos = AppRoute.childOf('Todos', AppActivity, defaultPath: 'Pending');
  static final AppRoute TodosPending = AppRoute.childOf('Pending', ActivityTodos);
  static final AppRoute TodosDone = AppRoute.childOf('Done', ActivityTodos);

  static final AppRoute AppProjects = AppRoute.childOf('Projects', AppScreen, defaultPath: 'All');
  static final AppRoute ProjectsAll = AppRoute.childOf('All', AppProjects);
  static final AppRoute ProjectsMy = AppRoute.childOf('My Projects', AppProjects);
  static final AppRoute ProjectsStarred = AppRoute.childOf('Starred', AppProjects);

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
      assert(Routes.map.containsKey(route.defaultUrl), 'unknown url: \'${route.defaultUrl}\'');
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
