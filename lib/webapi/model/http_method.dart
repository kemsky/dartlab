library http_method;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'http_method.g.dart';

class HttpMethod extends EnumClass {
  static Serializer<HttpMethod> get serializer => _$httpMethodSerializer;

  static const HttpMethod post = _$post;
  static const HttpMethod get = _$get;

  const HttpMethod._(String name) : super(name);

  static BuiltSet<HttpMethod> get values => _$httpMethodValues;

  static HttpMethod valueOf(String name) => _$httpMethodValueOf(name);
}
