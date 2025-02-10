import 'package:map_converter/map_converter.dart';

import '../person/person.dart';

@MapConverter()
class Example {
  Set<bool> setOfBool = {};
  Set<Gender> setOfGender = {};
  Set<Person> setOfPerson = {};
  Set<int?> setOfNullableInt = {};
  Set<double>? nullableSetOfDouble = {};
  Set<String?>? nullableSetOfNullableStrings = {};
  //TODO Set<Set<Person>> setOfSetOfPerson = {};
  //TODO Set<Set<Person?>?>? nullableSetOfNullableSetOfNullablePersonSet;
}
