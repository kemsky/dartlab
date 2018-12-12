import 'package:dart_lab/database/database_client.dart';
import 'package:dart_lab/database/model/database_serializers.dart';
import 'package:dart_lab/database/model/application_user.dart';
import 'package:dart_lab/database/repository.dart';
import 'package:logging/logging.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository {
  final Logger logger = new Logger('UserRepository');

  final DatabaseClient _client;

  UserRepository(this._client);

  Observable<Optional<ApplicationUser>> get() {
    return KeyValueRepository(this._client)
        .load(ApplicationUser)
        .map((map) {
      if (map.isEmpty) {
        return Optional.absent();
      }
      return Optional.of(model_serializers.deserializeWith(ApplicationUser.serializer, map));
    });
  }

  Observable<void> save(ApplicationUser user) {
    return KeyValueRepository(this._client).save(user);
  }

  Observable<void> remove() {
    return KeyValueRepository(this._client).delete(ApplicationUser);
  }
}
