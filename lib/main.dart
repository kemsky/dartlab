import 'package:dart_lab/components/application.dart';
import 'package:dart_lab/database/database_client.dart';
import 'package:dart_lab/database/database_manager.dart';
import 'package:dart_lab/database/database_repository.dart';
import 'package:dart_lab/database/model/application_user.dart';
import 'package:dart_lab/database/user_repository.dart';
import 'package:dart_lab/middleware/middleware.dart';
import 'package:dart_lab/routes.dart';
import 'package:dart_lab/state/actions.dart';
import 'package:dart_lab/state/reducers.dart';
import 'package:dart_lab/state/state.dart';
import 'package:dart_lab/webapi/gitlab_api.dart';
import 'package:dart_lab/webapi/model/gitlab_current_user.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';
import 'main.reflectable.dart';

//todo: Add Error Reporting https://flutter.io/docs/cookbook/maintenance/error-reporting

final Logger _logger = new Logger('main');

void main(List<String> arguments) {
  initializeReflectable();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: [${rec.loggerName}]: ${rec.message}');
  });

  _logger.info("Starting application...");

  Routes.initialize();

  final dev_host = arguments.length == 2 ? arguments[0] : null;
  final dev_token = arguments.length == 2 ? arguments[1] : null;

  if (arguments.length > 0) {
    _logger.info("Development mode: host='$dev_host', token='$dev_token'");
  }

  final repository = UserRepository(DatabaseRepository(DatabaseClient(DatabaseService())));

  repository.get().listen((optionalUser) {
    final store = Store<AppState>(appReducer, initialState: AppState.initial(optionalUser, dev_host, dev_token), middleware: createAppStateMiddleware());

    runApp(ApplicationStoreProvider(store));

    store.dispatch(loadPackageInfoAction);

    final refresh = repository.get().flatMap((optionalUser) {
      if (optionalUser.isEmpty) {
        return Observable.just(Optional<ApplicationUser>.absent());
      }
      final user = optionalUser.value;

      return GitLabApi(user.host, user.token).getCurrentUser().flatMap((optionalRemoteUser) {
        if (optionalRemoteUser.isEmpty) {
          return repository.remove().flatMap((user) => Observable.just(Optional<ApplicationUser>.absent()));
        } else {
          final GitLabCurrentUser remoteUser = optionalRemoteUser.value;
          final ApplicationUser updatedUser = user.rebuild((builder) {
            builder.fullName = remoteUser.name;
            builder.avatarUrl = remoteUser.avatar_url;
            builder.email = remoteUser.email;
          });
          return repository.save(updatedUser).map((_) => Optional.of(updatedUser));
        }
      });
    });
    refresh.listen((optionalUser) {
      logger.info('refresh success: $optionalUser');
      store.dispatch(SetApplicationUserAction(optionalUser.isNotEmpty ? optionalUser.value : null));
    });
  });
}
