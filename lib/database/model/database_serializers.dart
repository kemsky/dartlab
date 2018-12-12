library database_serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/src/built_map_serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dart_lab/database/model/application_user.dart';

part 'database_serializers.g.dart';

@SerializersFor(const [
  ApplicationUser
])

final Serializers database_serializers = (
    _$database_serializers
        .toBuilder()
      ..add(Iso8601DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin())
).build();