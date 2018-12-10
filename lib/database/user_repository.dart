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

  Observable<Optional<User>> load() {
    return this._client.query('SELECT * from ${User.TableName} WHERE id > 1').map((list) {
      if (list.isEmpty) {
        return Optional.absent();
      }
      var row = list.first;
      return Optional.of(model_serializers.deserializeWith(User.serializer, row));
    });
  }

  Observable<int> save(User user) {
    if (user.id != null && user.id > 0) {
      List<dynamic> params = [user.token, user.url, user.fullName, user.email, user.avatarUrl, user.id];
      var statement = 'UPDATE ${User.TableName} SET token = ?, url = ?, fullName = ?, email = ?, avatarUrl = ? WHERE id = ?';
      return this._client.update(statement, params).map((_) => user.id);
    } else {
      List<dynamic> params = [user.token, user.url, user.fullName ?? '', user.email ?? '', user.avatarUrl ?? ''];
      var statement = 'INSERT INTO ${User.TableName} (token, url, fullName, email, avatarUrl) VALUES (?, ?, ?, ?, ?)';
      return this._client.insert(statement, params);
    }
  }
}
