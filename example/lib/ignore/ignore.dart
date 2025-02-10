import 'package:map_converter/map_converter.dart';

@MapConverter([Property.ignore('skip')])
class Example {
  bool keep = true;
  String skip = 'ignore';
}
