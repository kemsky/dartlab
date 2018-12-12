import 'dart:convert';

import 'package:dart_lab/webapi/model/http_method.dart';
import 'package:dart_lab/webapi/model/http_request.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:dart_lab/webapi/api.configuration.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

abstract class ApiClass {
  final Configuration Config;

  @protected
  ApiClass(this.Config);

  @protected
  Observable<Response> execute(HttpRequestBuilder requestBuilder) {
    var request = requestBuilder.build();

    var path = [(request.secure ? 'https' : 'http') + '://' + request.host];

    path.addAll(request.path);

    var search = request.search.map((key, value) => MapEntry(key, '${key}=${value}')).values;

    var url = path.join('/') + (search.length > 0 ? '?' + search.join('&') : '');

    switch(request.method) {
      case HttpMethod.get:
        return Observable.fromFuture(http.get(url, headers: request.headers.asMap()));
        break;
      case HttpMethod.post:
        return Observable.fromFuture(http.post(url, headers: request.headers.asMap()));
        break;
      default:
        throw 'Unsupported method: ${request.method}';
    }
  }

  @protected
  HttpRequestBuilder request(HttpMethod method) {
    var request = HttpRequestBuilder();
    request.headers.update((headers) {
      headers.addAll({'Private-Token': this.Config.PersonalToken, 'Content-Type': 'application/json', 'Accept': 'application/json'});
    });
    request.host = this.Config.Host;
    request.secure = this.Config.IsSecure;
    request.path.update((path) {
      path.add('api');
      path.add('v4');
    });
    request.method = method;
    request.search.update((search){});
    request.encoding = Encoding.getByName('UTF-8');
    return request;
  }
}
