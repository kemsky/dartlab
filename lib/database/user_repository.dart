library user_repository;

import 'package:dart_lab/database/model/application_user.dart';
import 'package:dart_lab/database/database_repository.dart';
import 'package:logging/logging.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

abstract class UserRepository {

  Observable<Optional<ApplicationUser>> get();

  Observable<void> save(ApplicationUser user);

  Observable<void> remove();

  factory UserRepository(DatabaseRepository repository) {
    return UserRepositoryImpl(repository);
  }
}

class UserRepositoryImpl implements UserRepository {
  static final Logger _logger = new Logger('UserRepository');

  static final String _Key = 'application_user';

  final DatabaseRepository _repository;

  UserRepositoryImpl(this._repository);

  Observable<Optional<ApplicationUser>> get() {
    return this._repository.load(_Key, ApplicationUser);
  }

  Observable<void> save(ApplicationUser user) {
    return this._repository.save(_Key, user);
  }

  Observable<void> remove() {
    return this._repository.delete(_Key);
  }
}
