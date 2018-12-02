import 'package:json_annotation/json_annotation.dart';

part 'package:dart_lab/webapi/model/identity.g.dart';

@JsonSerializable(nullable: false)
class Identity {
  final String provider;
  final String extern_uid;

  Identity(this.provider, this.extern_uid);

  factory Identity.fromJson(Map<String, dynamic> json) => _$IdentityFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityToJson(this);
}
