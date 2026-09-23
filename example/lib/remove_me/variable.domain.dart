import 'package:collection/collection.dart';
import 'package:map_converter/map_converter.dart';

/// A named [Node] for building tree models.
abstract class Node<CHILD_TYPE extends Node<CHILD_TYPE>> {
  String get name;
  String get comment;
  List<CHILD_TYPE> get children;

  List<CHILD_TYPE> get descendants {
    List<CHILD_TYPE> all = [];
    for (var child in children) {
      all.add(child);
      all.addAll(child.descendants);
    }
    return all;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Node && runtimeType == other.runtimeType && name == other.name;
  //  &&
  // const ListEquality().equals(children, other.children);

  @override
  int get hashCode => name.hashCode ^ children.hashCode;

  @override
  String toString() {
    String string = '$runtimeType {name: $name}';
    for (var child in children) {
      var lines = child.toString().split('\n');
      for (var line in lines) {
        string += "\n  $line";
      }
    }
    return string;
  }

  T findFirstNodePath<T extends NodePath>(NodePathFinder<T> finder) =>
      finder(this);

  List<T> findAllNodePaths<T extends NodePath>(NodePathsFinder<T> finder) =>
      finder(this);
}

typedef NodePathFinder<T extends NodePath> = T Function(Node node);

typedef NodePathsFinder<T extends NodePath> = List<T> Function(Node node);

@MapConverter(
    discriminatorKey: 'type', includeSubClasses: [ArrayType, DataType])
//abstract interface class BaseType {}
class BaseType {
  String name = '';
}

/// All built‑in types supported by Sysmac Studio.
/// Omron explicitly lists these as “Basic Data Types.”
abstract interface class BasicType implements BaseType {}

/// Variables and some BaseTypes have a baseType
/// Note that [baseType] is not final because when it is an [UnknownBaseType]
/// it might need to be replaced with a  [DataTypeMember] in a later stage.
/// See [BaseTypeFactory.]
abstract interface class BaseTypeOwner {
  BaseType get baseType;
  set baseType(BaseType baseType);
}

class ArrayRange {
  static final minName = 'min';
  static final maxName = 'max';
  // static final FluentRegex _numberRegex = FluentRegex().digit(
  //   Quantity.oneOrMoreTimes(),
  // );
  // static final FluentRegex regex = FluentRegex()
  //     .group(_numberRegex, type: GroupType.captureNamed(minName))
  //     .literal('..')
  //     .group(_numberRegex, type: GroupType.captureNamed(maxName))
  //     .literal(',', Quantity.zeroOrOneTime());

  final int min;
  final int max;
  late final int size = (max - min) + 1;

  ArrayRange(String expression)
      : min = _numberFromExpression(expression, minName),
        max = _numberFromExpression(expression, maxName);

  ArrayRange.minMax(this.min, this.max);

  @override
  String toString() {
    return '$min..$max';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArrayRange &&
          runtimeType == other.runtimeType &&
          min == other.min &&
          max == other.max;

  @override
  int get hashCode => min.hashCode ^ max.hashCode;

  static int _numberFromExpression(String expression, String groupName) {
    // var value = regex.firstMatch(expression)!.namedGroup(groupName)!;
    // return int.parse(value);
    return -1; //dummy
  }
}

class ArrayRanges extends DelegatingList<ArrayRange> {
  ArrayRanges([super.arrayRanges = const <ArrayRange>[]]);

  /// e.g.
  /// if [ArrayRanges] represents [ArrayRange(min:2, max:3), ArrayRange(min:5, max:7)]
  /// then outputs: [[2,3], [5,6,7]]
  List<List<int>> toIntLists() => map(
        (range) =>
            List.generate(range.max - range.min + 1, (i) => range.min + i),
      ).toList();

  /// e.g.
  /// if [ArrayRanges] represents [ArrayRange(min:2, max:3), ArrayRange(min:5, max:7)]
  /// then outputs: ['[2,5]','[2,6]','[2,7]','[3,5]','[3,6]','[3,7]']
  List<String> toStringList() {
    final valueLists = toIntLists();
    final combinations = _cartesianProduct(valueLists);
    return combinations.map((combo) => '[${combo.join(',')}]').toList();
  }

  /// Helper to compute the cartesian product of a list of lists
  List<List<int>> _cartesianProduct(List<List<int>> lists) {
    if (lists.isEmpty) return [];

    List<List<int>> result = [[]];
    for (var list in lists) {
      result = [
        for (var prefix in result)
          for (var item in list) [...prefix, item],
      ];
    }
    return result;
  }

  String toTypeExpression() {
    if (isEmpty) {
      return '';
    }
    var expression = StringBuffer();
    expression.write('ARRAY[');
    for (var arrayRange in this) {
      if (expression.length > 6) {
        expression.write(', ');
      }
      expression.write(arrayRange.min);
      expression.write('..');
      expression.write(arrayRange.max);
    }
    expression.write('] OF ');
    return expression.toString();
  }

  @override
  String toString() {
    if (isEmpty) return '';
    return super.toString();
  }
}

/// Wraps a [BaseType] in an [ArrayType] with the given [arrayRanges]
class ArrayType {
  //implements BasicType, BaseTypeOwner {
  @override
  BaseType baseType;
  final ArrayRanges arrayRanges;

  ArrayType({required this.baseType, required this.arrayRanges});

  @override
  String toString() {
    return 'ARRAY$arrayRanges OF $baseType';
  }
}

class NodePath extends DelegatingList<Node> {
  NodePath(super.base);

  const NodePath.empty() : super(const []);

  Iterable<String> toNamePath() => map((node) => node.name).toList();

  Iterable<String> toNamePathWithArrayRanges() => map(
        (node) => (node is ArrayType)
            ? '${node.name}${(node as ArrayType).arrayRanges}'
            : node.name,
      );

  List<String> toCommentPath() => map((node) => node.comment).toList();

  @override
  String toString() => toNamePath().join('.');
}

/// Types that the programmer defines, or that Sysmac creates automatically.
abstract interface class CustomType implements BaseType {}

/// Abstract base type of [DataType]s and [NameSpace]s
abstract interface class DataTypeBase extends Node<DataTypeBase>
    implements CustomType {}

/// A [DataType] is a custom data type that is made of [BaseType]s
abstract interface class DataType extends DataTypeBase {}

@MapConverter(generateOptions: GenerateOptions.toMap + GenerateOptions.schema)
class Variable extends Node<DataTypeBase> implements BaseTypeOwner {
  @override
  final String name;
  @override
  final String comment;
  final NetworkPublish networkPublish;
  @override
  BaseType baseType;
  final String? hardwareAddress;
  final VariableDirection? direction;
  final bool isRetained;
  final bool isConstant;
  final String? initialValue;

  @override
  List<DataTypeBase> get children {
    var leaf = baseTypeLeaf(baseType);
    if (leaf is DataType) {
      return leaf.children;
    } else {
      return [];
    }
  }

  Variable({
    required this.name,
    required this.comment,
    required this.networkPublish,
    required this.baseType,
    this.hardwareAddress,
    this.direction,
    this.isRetained = false,
    this.isConstant = false,
    this.initialValue,
  });
}

enum VariableGroup {
  global,
  internal,
  external,
  unknown,
  functionInOut,
  functionReturn,
}

enum VariableDirection { in$, out, inOut }

enum NetworkPublish {
  publicationOnly,
  doNotPublish,
  input,
  output;

  static NetworkPublish ofValue(String? value) => value == null
      ? doNotPublish
      : values.firstWhere(
          (v) => v.name.toLowerCase() == value.toLowerCase(),
          orElse: () => doNotPublish,
        );
}

/// Finds the last baseType in a baseType tree
BaseType baseTypeLeaf(BaseType baseType) {
  if (baseType is BaseTypeOwner) {
    /// recursively get last baseType in tree
    return baseTypeLeaf((baseType as BaseTypeOwner).baseType);
  } else {
    return baseType;
  }
}
