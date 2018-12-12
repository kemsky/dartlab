library rest_client;

import 'dart:convert';
import 'package:dart_lab/webapi/model/http_method.dart';
import 'package:dart_lab/webapi/model/http_request.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

abstract class RestClient {
  final String host;
  final bool secure;
  final Map<String, String> headers;
  final List<String> path;

  @protected
  RestClient(this.host, {this.secure = true, this.headers = const {}, this.path = const ['api', 'v4']});

  @protected
  Observable<Response> execute(HttpRequestBuilder requestBuilder) {
    var request = requestBuilder.build();

    var path = [(request.secure ? 'https' : 'http') + '://' + request.host];

    path.addAll(request.path);

    var search = request.search.map((key, value) => MapEntry(key, '${key}=${value}')).values;

    var url = path.join('/') + (search.length > 0 ? '?' + search.join('&') : '');

    switch (request.method) {
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
  HttpRequestBuilder request(HttpMethod method, {Map<String, String> headers = null, String host = null, bool secure = null, List<String> path = null}) {
    var request = HttpRequestBuilder();
    request.headers.update((builder) {
      if (headers == null) {
        builder.addAll({'Content-Type': 'application/json', 'Accept': 'application/json'});
        if (this.headers != null) {
          builder.addAll(this.headers);
        }
      } else {
        builder.addAll(headers);
      }
    });
    request.host = host ?? this.host;
    request.secure = secure ?? this.secure;
    request.path.update((builder) {
      if (path == null) {
        builder.add('api');
        builder.add('v4');
      } else if (this.path != null) {
        builder.addAll(this.path);
      }
    });
    request.method = method;
    request.search.update((search) {});
    request.encoding = Encoding.getByName('UTF-8');
    return request;
  }
}
