import 'package:dart_lab/database/database_client.dart';
import 'package:dart_lab/database/model/database_serializers.dart';
import 'package:dart_lab/database/model/user.dart';
import 'package:logging/logging.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository {
  final Logger logger = new Logger('UserRepository');

  final DatabaseClient _client;

  UserRepository(this._client);

  Observable<Optional<User>> get() {
    return this._client.query('SELECT * from ${User.TableName} WHERE id = 1').map((list) {
      if (list.isEmpty) {
        return Optional.absent();
      }

      assert(list.length == 1);

      var row = list.first;
      return Optional.of(model_serializers.deserializeWith(User.serializer, row));
    });
  }

  Observable<void> save(User user) {
    List<dynamic> params = [user.token, user.url, user.fullName ?? '', user.email ?? '', user.avatarUrl ?? ''];

    var statement = 'INSERT INTO ${User.TableName} (id, token, url, fullName, email, avatarUrl) VALUES (1, ?, ?, ?, ?, ?)';

    return this._client.query(statement, params);
  }

  Observable<void> remove() {
    return this._client.update("DELETE FROM ${User.TableName}");
  }
}
