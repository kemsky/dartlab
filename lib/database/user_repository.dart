import 'package:dart_lab/database/database_client.dart';
import 'package:dart_lab/database/model/database_serializers.dart';
import 'package:dart_lab/database/model/user.dart';
import 'package:dart_lab/database/repository.dart';
import 'package:logging/logging.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository {
  final Logger logger = new Logger('UserRepository');

  final DatabaseClient _client;

  UserRepository(this._client);

  Observable<Optional<User>> get() {
    return KeyValueRepository(this._client)
        .load(['token', 'url'])
        .map((map) {
      if (map.isEmpty) {
        return Optional.absent();
      }
      return Optional.of(model_serializers.deserializeWith(User.serializer, map));
    });
  }

  Observable<void> save(User user) {
    return KeyValueRepository(this._client).save(user);
  }

  Observable<void> remove() {
    return this._client.update("DELETE FROM ${User.TableName}");
  }
}
