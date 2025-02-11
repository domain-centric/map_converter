import 'package:map_converter/map_converter.dart';

import '../person/person.dart';

@MapConverter()
class Example {
  late Person myPerson;
  late Person? myNullablePerson;
}
