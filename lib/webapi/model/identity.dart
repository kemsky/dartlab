library identity;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'identity.g.dart';

abstract class Identity implements Built<Identity, IdentityBuilder> {
  static Serializer<Identity> get serializer => _$identitySerializer;

  String get provider;
  String get extern_uid;

  Identity._();

  factory Identity([updates(IdentityBuilder b)]) =_$Identity;
}
