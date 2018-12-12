library http_request;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:dart_lab/webapi/model/http_method.dart';

part 'http_request.g.dart';

abstract class HttpRequest implements Built<HttpRequest, HttpRequestBuilder> {
  static Serializer<HttpRequest> get serializer => _$httpRequestSerializer;

  String get host;

  bool get secure;

  Encoding get encoding;

  HttpMethod get method;

  BuiltList<String> get path;

  BuiltMap<String, String> get headers;

  BuiltMap<String, String> get search;

  HttpRequest._();

  factory HttpRequest([updates(HttpRequestBuilder b)]) =_$HttpRequest;
}
