import 'dart:convert';

import 'package:dart_lab/webapi/model/current.user.dart';
import 'package:dart_lab/webapi/api.class.dart';
import 'package:dart_lab/webapi/api.configuration.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class Users extends ApiClass {
  Users(Configuration config) : super(config);

  Observable<CurrentUser> getCurrentUser() {
    return Observable.fromFuture(http.get(this.createUrl() + 'user', headers: this.createHeaders()))
        .map((response) => CurrentUser.fromJson(json.decode(response.body)));
  }
}
