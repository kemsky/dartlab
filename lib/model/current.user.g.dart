// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current.user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) {
  return CurrentUser(
      json['id'] as int,
      json['username'] as String,
      json['email'] as String,
      json['name'] as String,
      json['state'] as String,
      json['avatar_url'] as String,
      json['web_url'] as String,
      DateTime.parse(json['created_at'] as String),
      json['is_admin'] as bool,
      json['bio'] as String,
      json['location'] as String,
      json['public_email'] as String,
      json['skype'] as String,
      json['linkedin'] as String,
      json['twitter'] as String,
      json['website_url'] as String,
      json['organization'] as String,
      DateTime.parse(json['last_sign_in_at'] as String),
      DateTime.parse(json['confirmed_at'] as String),
      json['theme_id'] as int,
      DateTime.parse(json['last_activity_on'] as String),
      json['color_scheme_id'] as int,
      json['projects_limit'] as int,
      DateTime.parse(json['current_sign_in_at'] as String),
      (json['identities'] as List)
          .map((e) => Identity.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['can_create_group'] as bool,
      json['can_create_project'] as bool,
      json['two_factor_enabled'] as bool,
      json['external'] as bool,
      json['private_profile'] as bool);
}

Map<String, dynamic> _$CurrentUserToJson(CurrentUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'name': instance.name,
      'state': instance.state,
      'avatar_url': instance.avatar_url,
      'web_url': instance.web_url,
      'created_at': instance.created_at.toIso8601String(),
      'is_admin': instance.is_admin,
      'bio': instance.bio,
      'location': instance.location,
      'public_email': instance.public_email,
      'skype': instance.skype,
      'linkedin': instance.linkedin,
      'twitter': instance.twitter,
      'website_url': instance.website_url,
      'organization': instance.organization,
      'last_sign_in_at': instance.last_sign_in_at.toIso8601String(),
      'confirmed_at': instance.confirmed_at.toIso8601String(),
      'theme_id': instance.theme_id,
      'last_activity_on': instance.last_activity_on.toIso8601String(),
      'color_scheme_id': instance.color_scheme_id,
      'projects_limit': instance.projects_limit,
      'current_sign_in_at': instance.current_sign_in_at.toIso8601String(),
      'identities': instance.identities,
      'can_create_group': instance.can_create_group,
      'can_create_project': instance.can_create_project,
      'two_factor_enabled': instance.two_factor_enabled,
      'external': instance.external,
      'private_profile': instance.private_profile
    };
