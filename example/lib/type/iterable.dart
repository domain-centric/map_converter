// import 'package:json_annotation/json_annotation.dart';
import 'package:map_converter/map_converter.dart';

import '../person/person.dart';

//  part 'iterable.g.dart';

// @JsonSerializable()

@MapConverter()
class Example {
  late Iterable<bool> iterableOfBool;
  late Iterable<Gender> iterableOfGender;
  late Iterable<Person> iterableOfPerson;
  late Iterable<int?> iterableOfNullableInt;
  late Iterable<double>? nullableIterableOfDouble;
  late Iterable<String?>? nullableIterableOfNullableStrings;
  //TODO Iterable<Iterable<Person>> iterableOfIterableOfPerson;
  //TODO Iterable<Iterable<Person?>?>? nullableIterableOfNullableIterableOfNullablePersonIterable;
}
