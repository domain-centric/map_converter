import 'package:map_converter/map_converter.dart';

@MapConverter(includeSubClasses: [Dog, Cat, Bird])
abstract class Animal {
  const Animal();

  String get name;
}

@MapConverter()
class Dog extends Animal {
  const Dog({
    required this.name,
    required this.barkVolume,
  });

  @override
  final String name;

  final int barkVolume;
}

@MapConverter()
class Cat extends Animal {
  const Cat({
    required this.name,
    required this.livesLeft,
  });

  @override
  final String name;

  final int livesLeft;
}

@MapConverter()
class Bird extends Animal {
  const Bird({
    required this.name,
    required this.wingSpan,
  });

  @override
  final String name;

  final double wingSpan;
}

@MapConverter()
class PetClinic {
  final List<Animal> animals;

  PetClinic(this.animals);
}
