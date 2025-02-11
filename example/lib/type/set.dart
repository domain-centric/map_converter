import 'package:map_converter/map_converter.dart';

import '../person/person.dart';

@MapConverter()
class Example {
  late Set<bool> setOfBool;
  late Set<Gender> setOfGender;
  late Set<Person> setOfPerson;
  late Set<int?> setOfNullableInt;
  late Set<double>? nullableSetOfDouble;
  late Set<String?>? nullableSetOfNullableStrings;
  //TODO Set<Set<Person>> setOfSetOfPerson;
  //TODO Set<Set<Person?>?>? nullableSetOfNullableSetOfNullablePersonSet;
}
