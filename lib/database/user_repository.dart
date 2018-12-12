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
  static final Logger logger = new Logger('UserRepository');

  static final String Key = 'ApplicationUser';

  final DatabaseRepository _repository;

  UserRepositoryImpl(this._repository);

  Observable<Optional<ApplicationUser>> get() {
    return this._repository.load(Key, ApplicationUser);
  }

  Observable<void> save(ApplicationUser user) {
    return this._repository.save(Key, user);
  }

  Observable<void> remove() {
    return this._repository.delete(Key);
  }
}
