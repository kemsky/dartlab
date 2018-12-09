import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_status.g.dart';

class UserStatus extends EnumClass {
  static Serializer<UserStatus> get serializer => _$userStatusSerializer;

  static const UserStatus active = _$active;
  static const UserStatus inactive = _$inactive;

  const UserStatus._(String name) : super(name);

  static BuiltSet<UserStatus> get values => _$userStatusValues;

  static UserStatus valueOf(String name) => _$userStatusValueOf(name);
}
