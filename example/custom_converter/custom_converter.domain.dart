import 'package:map_converter/map_converter.dart';

@MapConverter([
  Property(
    'duration',
    converter: MyCustomConverter(),
  )
])
class CustomMappingExample {
  final Duration duration;

  CustomMappingExample(this.duration);
}

class MyCustomConverter extends PrimitiveConverter<DateTime, int> {
  const MyCustomConverter();

  @override
  int toPrimitive(DateTime value) => value.millisecondsSinceEpoch;

  @override
  DateTime fromPrimitive(int value) =>
      DateTime.fromMillisecondsSinceEpoch(value);
}
