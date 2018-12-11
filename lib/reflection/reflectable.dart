import 'package:reflectable/reflectable.dart';
import 'package:reflectable/capability.dart';

class Reflector extends Reflectable {
  const Reflector() : super(
      typeAnnotationQuantifyCapability,
      invokingCapability,
      declarationsCapability,
      typeRelationsCapability,
      metadataCapability
  );
}

const reflector = const Reflector();