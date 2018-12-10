import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/src/built_map_serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dart_lab/database/model/user.dart';

part 'model_serializers.g.dart';

@SerializersFor(const [
  User
])

final Serializers model_serializers = (
    _$model_serializers
        .toBuilder()
      ..add(Iso8601DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin())
).build();