import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dart_lab/webapi/model/identity.dart';

part 'current.user.g.dart';

abstract class CurrentUser implements Built<CurrentUser, CurrentUserBuilder> {
  static Serializer<CurrentUser> get serializer => _$currentUserSerializer;

  int get id;
  String get username;
  String get email;
  String get name;
  String get state;
  String get avatar_url;
  String get web_url;
  DateTime get created_at;
  bool get is_admin;
  String get bio;
  String get location;
  String get public_email;
  String get skype;
  String get linkedin;
  String get twitter;
  String get website_url;
  String get organization;
  DateTime get last_sign_in_at;
  DateTime get confirmed_at;
  int get theme_id;
  DateTime get last_activity_on;
  int get color_scheme_id;
  int get projects_limit;
  DateTime get current_sign_in_at;
  BuiltList<Identity> get identities;
  bool get can_create_group;
  bool get can_create_project;
  bool get two_factor_enabled;
  bool get external;
  @nullable
  String get private_profile;

  CurrentUser._();

  factory CurrentUser([updates(CurrentUserBuilder b)]) =_$CurrentUser;
}