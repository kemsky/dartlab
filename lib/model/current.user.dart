import 'package:flutter_example/model/identity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package:flutter_example/model/current.user.g.dart';

@JsonSerializable(nullable: false)
class CurrentUser {
  final int id;
  final String username;
  final String email;
  final String name;
  final String state;
  final String avatar_url;
  final String web_url;
  final DateTime created_at;
  final bool is_admin;
  final String bio;
  final String location;
  final String public_email;
  final String skype;
  final String linkedin;
  final String twitter;
  final String website_url;
  final String organization;
  final DateTime last_sign_in_at;
  final DateTime confirmed_at;
  final int theme_id;
  final DateTime last_activity_on;
  final int color_scheme_id;
  final int projects_limit;
  final DateTime current_sign_in_at;
  final List<Identity> identities;
  final bool can_create_group;
  final bool can_create_project;
  final bool two_factor_enabled;
  final bool external;
  final bool private_profile;

  CurrentUser(this.id, this.username, this.email, this.name, this.state,
      this.avatar_url, this.web_url, this.created_at, this.is_admin, this.bio,
      this.location, this.public_email, this.skype, this.linkedin, this.twitter,
      this.website_url, this.organization, this.last_sign_in_at,
      this.confirmed_at, this.theme_id, this.last_activity_on,
      this.color_scheme_id, this.projects_limit, this.current_sign_in_at,
      this.identities, this.can_create_group, this.can_create_project,
      this.two_factor_enabled, this.external, this.private_profile);

  factory CurrentUser.fromJson(Map<String, dynamic> json) => _$CurrentUserFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);
}