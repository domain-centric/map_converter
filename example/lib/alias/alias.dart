import 'package:map_converter/map_converter.dart';

@MapConverter(fields: [
  Field(#email, alias: 'emailAddress'),
  Field(#phoneNumber, alias: 'contactNumber'),
])
class Example {
  final String email;
  final int phoneNumber;
  final String name;

  Example({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}
