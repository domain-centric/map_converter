import 'package:map_converter/map_converter.dart';

@MapConverter(generateOptions: GenerateOptions.toMap)
class ToMapExample {
  final String email;
  final int phoneNumber;

  ToMapExample(this.email, this.phoneNumber);
}

@MapConverter(generateOptions: GenerateOptions.fromMap)
class FromMapExample {
  final String email;
  final int phoneNumber;

  FromMapExample(this.email, this.phoneNumber);
}

@MapConverter(generateOptions: GenerateOptions.schema)
class SchemaExample {
  final String email;
  final int phoneNumber;

  SchemaExample(this.email, this.phoneNumber);
}

@MapConverter(generateOptions: GenerateOptions.toMap + GenerateOptions.schema)
class MapAndSchemaExample {
  final String email;
  final int phoneNumber;

  MapAndSchemaExample(this.email, this.phoneNumber);
}

@MapConverter(generateOptions: GenerateOptions.all)
class AllExample {
  final String email;
  final int phoneNumber;

  AllExample(this.email, this.phoneNumber);
}
