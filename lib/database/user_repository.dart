import 'package:dart_lab/database/database_client.dart';
import 'package:dart_lab/database/model/model_serializers.dart';
import 'package:dart_lab/database/model/user.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository {
  final DatabaseClient _client;

  UserRepository(this._client);

  Observable<Optional<User>> getUser() {
    return this._client
        .select('select * from Test LIMIT 1')
        .map((list) {
          if(list.isEmpty){
            return Optional.absent();
          }
          var first = list.first;
          return Optional.of(model_serializers.deserializeWith(User.serializer, first));
    });
  }
}