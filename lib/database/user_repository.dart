import 'package:dart_lab/database/database_client.dart';
import 'package:dart_lab/database/model/application_user.dart';
import 'package:dart_lab/database/database_repository.dart';
import 'package:logging/logging.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository {
  static final String Key = 'ApplicationUser';

  final Logger logger = new Logger('UserRepository');

  final DatabaseClient _client;

  UserRepository(this._client);

  Observable<Optional<ApplicationUser>> get() {
    return DatabaseRepository(this._client).load(Key, ApplicationUser);
  }

  Observable<void> save(ApplicationUser user) {
    return DatabaseRepository(this._client).save(Key, user);
  }

  Observable<void> remove() {
    return DatabaseRepository(this._client).delete(Key);
  }
}
