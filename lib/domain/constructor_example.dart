class DefaultConstructorExample {
  String property1 = '';
  String? property2;
}

class ConstructorExample {
  String property1 = '';
  String? property2;

  ConstructorExample();
}

class ConstructorWithRequiredPositionalParametersExample {
  final String property1;
  String? property2;
  String property3 = '';
  String? property4;

  ConstructorWithRequiredPositionalParametersExample(
    this.property1,
    this.property2,
  );
}

class ConstructorWithNamedParametersExample {
  String property1;
  final String? property2;
  String property3 = '';
  String? property4;

  ConstructorWithNamedParametersExample({
    required this.property1,
    this.property2,
  });
}

class ConstructorWithRequiredPositionalParametersAndNamedParametersExample {
  String property1;
  String? property2;
  final String property3;
  String? property4;
  String property5 = '';
  String? property6;

  ConstructorWithRequiredPositionalParametersAndNamedParametersExample(
    this.property1,
    this.property2, {
    required this.property3,
    this.property4,
  });
}

class ConstructorWithOptionalParametersExample {
  final String property1;
  String? property2;
  String property3 = '';
  String? property4;

  ConstructorWithOptionalParametersExample([
    this.property1 = '',
    this.property2,
  ]);
}

class ConstructorWithRequiredPositionalParametersAndOptionalParametersExample {
  String property1;
  String? property2;
  String property3;
  final String? property4;
  String property5 = '';
  String? property6;

  ConstructorWithRequiredPositionalParametersAndOptionalParametersExample(
    this.property1,
    this.property2, [
    this.property3 = '',
    this.property4,
  ]);
}

class NamedConstructorWithRequiredPositionalParametersAndNamedParametersExample {
  String property1;
  String? property2;
  final String property3;
  String? property4;
  String property5 = '';
  String? property6;

  NamedConstructorWithRequiredPositionalParametersAndNamedParametersExample.name(
    this.property1,
    this.property2, {
    required this.property3,
    this.property4,
  });
}

class NamedConstructorWithRequiredPositionalParametersAndOptionalParametersExample {
  String property1;
  String? property2;
  String property3;
  final String? property4;
  String property5 = '';
  String? property6;

  NamedConstructorWithRequiredPositionalParametersAndOptionalParametersExample.name(
    this.property1,
    this.property2, [
    this.property3 = '',
    this.property4,
  ]);
}
//TODO named constructor

//TODO multiple constructors (with(out) invalid parameters)
