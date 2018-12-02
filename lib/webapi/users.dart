import 'dart:convert';

import 'package:dart_lab/webapi/model/current.user.dart';
import 'package:dart_lab/webapi/api.class.dart';
import 'package:dart_lab/webapi/api.configuration.dart';
import 'package:http/http.dart' as http;

class Users extends ApiClass {
  Users(Configuration config) : super(config);

  Future<CurrentUser> getCurrentUser() {
    return http.get(this.createUrl() + 'user', headers: this.createHeaders()).then((response) {
      return CurrentUser.fromJson(json.decode(response.body));
    });
  }
}
