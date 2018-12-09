import 'dart:convert';

import 'package:dart_lab/webapi/model/current_user.dart';
import 'package:dart_lab/webapi/api.class.dart';
import 'package:dart_lab/webapi/api.configuration.dart';
import 'package:dart_lab/webapi/model/model_serializers.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class Users extends ApiClass {
  Users(Configuration config) : super(config);

  Observable<CurrentUser> getCurrentUser() {
    return Observable.fromFuture(http.get(this.createUrl() + 'user', headers: this.createHeaders()))
        .doOnData((response) {
          print(response.body);
        })
        .map((response) => model_serializers.deserializeWith(CurrentUser.serializer, json.decode(response.body)));
  }
}
