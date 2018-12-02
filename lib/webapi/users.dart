import 'dart:convert';

import 'package:flutter_example/model/current.user.dart';
import 'package:flutter_example/webapi/configuration.dart';
import 'package:http/http.dart' as http;

class Users {
  Future<CurrentUser> getCurrentUser() {
    var headers = new Map<String, String>();

    headers.putIfAbsent('Private-Token', () => Configuration.PersonalToken);
    headers.putIfAbsent('Content-Type', () => 'application/json');
    headers.putIfAbsent('Accept', () => 'application/json');

    return http.get('https://${Configuration.Host}/api/v4/user', headers: headers).then((response) {
      return CurrentUser.fromJson(json.decode(response.body));
    });
  }
}
