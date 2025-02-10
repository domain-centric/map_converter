import 'package:map_converter/map_converter.dart';

import '../person/person.dart';

@MapConverter()
class Example {
  late Map<String, int> mapWithPrimitiveKeyAndPrimitiveValue;
  late Map<int, bool>? nullableMapWithPrimitiveKeyAndPrimitiveValue;
  late Map<double, String?> mapWithPrimitiveKeyAndPrimitiveNullableValue;
  // late Map<Person, int> mapWithComplexKeyAndPrimitiveValue;
  // late Map<Person?, int> mapWithComplexNullableKeyAndPrimitiveValue;
  late Map<int, Person> mapWithPrimitiveKeyAndComplexValue;
  late Map<int, Person?> mapWithPrimitiveKeyAndComplexNullableValue;
  late Map<int, List<Person>> mapWithPrimitiveKeyAndListValue;
  late Map<int, List<Gender>?> mapWithPrimitiveKeyAndNullableListValue;
  late Map<int, Map<int, Person?>> mapWithPrimitiveKeyAndMapValue;
  late Map<int, Map<int, Gender>?> mapWithPrimitiveKeyAndNullableMapValue;
}
