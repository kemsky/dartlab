import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dart_lab/webapi/model/current.user.dart';
import 'package:dart_lab/webapi/model/identity.dart';

part 'model_serializers.g.dart';

@SerializersFor(const [
  Identity,
  CurrentUser
])

final Serializers model_serializers = (
    _$model_serializers
        .toBuilder()
      ..add(Iso8601DateTimeSerializer()) // Support  DateTime deserialization
      ..addPlugin(StandardJsonPlugin())  // Support JSON deserialization
).build();