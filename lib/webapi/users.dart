import 'dart:convert';

import 'package:dart_lab/webapi/model/gitlab_current_user.dart';
import 'package:dart_lab/webapi/api.class.dart';
import 'package:dart_lab/webapi/api.configuration.dart';
import 'package:dart_lab/webapi/model/http_method.dart';
import 'package:dart_lab/webapi/model/webapi_serializers.dart';
import 'package:rxdart/rxdart.dart';

class Users extends ApiClass {
  Users(Configuration config) : super(config);

  Observable<GitLabCurrentUser> getCurrentUser() {
    final request = this.request(HttpMethod.get);

    request.path.update((path){
      path.add('user');
    });

    return this.execute(request)
        .doOnData((response) {
          print(response.body);
        })
        .map((response) => model_serializers.deserializeWith(GitLabCurrentUser.serializer, json.decode(response.body)));
  }
}
