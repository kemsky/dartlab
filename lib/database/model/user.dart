import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dart_lab/reflection/reflectable.dart';

part 'user.g.dart';

@reflector
abstract class User implements Built<User, UserBuilder> {
  static const String TableName = 'User';

  static Serializer<User> get serializer => _$userSerializer;

  String get token;

  String get url;

  @nullable
  String get fullName;

  @nullable
  String get email;

  @nullable
  String get avatarUrl;

  User._();

  factory User([updates(UserBuilder b)]) =_$User;
}