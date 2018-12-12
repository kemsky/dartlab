library application_user;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'application_user.g.dart';

abstract class ApplicationUser implements Built<ApplicationUser, ApplicationUserBuilder> {
  static Serializer<ApplicationUser> get serializer => _$applicationUserSerializer;

  String get token;

  String get url;

  @nullable
  String get fullName;

  @nullable
  String get email;

  @nullable
  String get avatarUrl;

  ApplicationUser._();

  factory ApplicationUser([updates(ApplicationUserBuilder b)]) =_$ApplicationUser;
}