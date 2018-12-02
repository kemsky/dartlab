// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Identity _$IdentityFromJson(Map<String, dynamic> json) {
  return Identity(json['provider'] as String, json['extern_uid'] as String);
}

Map<String, dynamic> _$IdentityToJson(Identity instance) => <String, dynamic>{
      'provider': instance.provider,
      'extern_uid': instance.extern_uid
    };
