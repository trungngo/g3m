part of g3.techlab;

/// Provides configuration for how [CodeType] node will render.
///
/// Here are some useful predefined factory methods:
/// [CodeTypeConfig.forJavaLike], [CodeTypeConfig.forDartLike]
/// that might work for many existing programming languages.
///
class CodeTypeConfig extends CodeConfigNode<CodeType> {
  CodeTypeConfig(NodeBuildFunc<CodeType> buildFunc, Node child)
      : super(buildFunc, child);

  /// Creates a data type config just like java language.
  /// It will work for csharp, typescript and many others.
  factory CodeTypeConfig.forJavaLike(Node child) =>
      CodeTypeConfig._internal(child, null);

  factory CodeTypeConfig.forDartLike(Node child) => CodeTypeConfig._internal(
        child,
        null,
        arrayClassName: 'List',
        nullableByDefault: false,
        nullableSuffix: '?',
      );

  factory CodeTypeConfig.forTypescriptLike(Node child) =>
      CodeTypeConfig._internal(
        child,
        null,
        nullableByDefault: false,
      );

  factory CodeTypeConfig.forKotlinLike(Node child, {StringFunc mapper}) =>
      CodeTypeConfig._internal(
        child,
        mapper,
        arrayClassName: 'Array',
        nullableByDefault: false,
        nullableSuffix: '?',
      );

  /// if [arrayClassName] is specified, the user the generic version
  /// of the array class name to build the type.
  ///
  factory CodeTypeConfig._internal(
    Node child,
    StringFunc mapper, {
    String arrayClassName,
    bool nullableByDefault,
    String nullableSuffix,
  }) =>
      CodeTypeConfig((context, type) {
        final params = type.generic;
        final array = type.array;

        Node name = type.name;
        if (type.instance != null) {
          name = Container([type.instance, '.', name]);
        }

        if (mapper != null) {
          name = TextTransform(name, mapper);
        }

        if (array != true && (params == null || params.params.isEmpty)) {
          // If there is no complex settings, just return the
          // type name.

        } else {
          if (params != null) {
            // Append generic params after the type.
            name = Container([
              name,
              params,
            ]);
          }

          if (array == true) {
            if (arrayClassName != null) {
              // Dart has syntax for array (or immutable list) as
              // List<T> as a example.
              name = Pad.of(arrayClassName + '<', '>', name);
            } else {
              // Other language often like T[].
              name = Pad.right('[]', name);
            }
          }
        }

        final nullable = type.nullable ?? nullableByDefault;
        if (nullable == true && nullableSuffix != null) {
          name = Pad.right(nullableSuffix, name);
        }
        return name;
      }, child);

  static CodeTypeConfig of(BuildContext context) {
    return context.dependOnAncestorNodeOfExactType<CodeTypeConfig>();
  }
}

/// Defines how to make a data type reference.
///
/// Important: [CodeTypeConfig] is a required ancestor for this node.
///
class CodeType extends CodeConfigProxyNode<CodeType> implements _NamedNode {
  /// The data type name.
  @override
  final CodeTypeName name;

  final CodeRef instance;

  /// The list of generic params.
  final CodeGenericParamList generic;

  /// True indicates that this is an array type.
  final bool array;

  /// True indicates that this is a nullable type.
  /// False indicates that must not be null.
  /// If this is null (not specified), then depending on the
  /// language settings. For instance, java accept most types are nullable
  /// by default while kotlin is not.
  final bool nullable;

  CodeType._(
      {this.instance, this.name, this.generic, this.array, this.nullable});

  static CodeType _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeType>(value, (v) {
      var name = CodeTypeName.of(v);
      if (name != null) {
        return CodeType._(name: name);
      }

      return null;
    }, error: error);
  }

  factory CodeType.of({
    dynamic instance,
    @required dynamic name,
    dynamic generic,
    bool array,
    bool nullable,
  }) {
    if (name == null && generic == null && array == null) {
      return null;
    }

    return CodeType._(
      instance: CodeRef.of(instance),
      name: CodeTypeName.of(name),
      generic: CodeGenericParamList.of(generic),
      array: array,
      nullable: nullable,
    );
  }

  // ---------------------------------------------------------------------------
  // Basic Types
  // See: https://developers.google.com/protocol-buffers/docs/proto3#scalar
  // ---------------------------------------------------------------------------

  static const _list = 'list';

  // --- Dynamic Type

  static const _dynamic = 'dynamic';

  factory CodeType.ofDynamic() => CodeType.simple(_dynamic);

  factory CodeType.arrayOfDynamic() => CodeType.array(_dynamic);

  factory CodeType.listOfDynamic() => CodeType.list(_dynamic);

  // --- Void Type

  static const _void = 'void';

  factory CodeType.ofVoid() => CodeType.simple(_void);

  // --- Bool Type

  static const _bool = 'bool';

  factory CodeType.ofBool() => CodeType.simple(_bool);

  factory CodeType.ofNullableBool() => CodeType.simple(_bool, nullable: true);

  factory CodeType.arrayOfBool() => CodeType.array(_bool);

  factory CodeType.listOfBool() => CodeType.list(_bool);

  // --- Char Type

  static const _char = 'char';

  factory CodeType.ofChar() => CodeType.simple(_char);

  factory CodeType.ofNullableChar() => CodeType.simple(_char, nullable: true);

  factory CodeType.arrayOfChar() => CodeType.array(_char);

  factory CodeType.listOfChar() => CodeType.list(_char);

  // --- String Type

  static const _string = 'string';

  factory CodeType.ofString() => CodeType.simple(_string);

  factory CodeType.ofNullableString() =>
      CodeType.simple(_string, nullable: true);

  factory CodeType.arrayOfString() => CodeType.array(_string);

  factory CodeType.listOfString() => CodeType.list(_string);

  // --- Byte Type

  static const _byte = 'byte';

  factory CodeType.ofByte() => CodeType.simple(_byte);

  factory CodeType.ofNullableByte() => CodeType.simple(_byte, nullable: true);

  factory CodeType.arrayOfByte() => CodeType.array(_byte);

  factory CodeType.listOfByte() => CodeType.list(_byte);

  // --- Short Type

  static const _short = 'short';

  factory CodeType.ofShort() => CodeType.simple(_short);

  factory CodeType.ofNullableShort() => CodeType.simple(_short, nullable: true);

  factory CodeType.arrayOfShort() => CodeType.array(_short);

  factory CodeType.listOfShort() => CodeType.list(_short);

  // --- Integer Type

  static const _integer = 'integer';

  factory CodeType.ofInteger() => CodeType.simple(_integer);

  factory CodeType.ofNullableInteger() =>
      CodeType.simple(_integer, nullable: true);

  factory CodeType.arrayOfInteger() => CodeType.array(_integer);

  factory CodeType.listOfInteger() => CodeType.list(_integer);

  // --- Long Type

  static const _long = 'long';

  factory CodeType.ofLong() => CodeType.simple(_long);

  factory CodeType.ofNullableLong() => CodeType.simple(_long, nullable: true);

  factory CodeType.arrayOfLong() => CodeType.array(_long);

  factory CodeType.listOfLong() => CodeType.list(_long);

  // --- Float Type

  static const _float = 'float';

  factory CodeType.ofFloat() => CodeType.simple(_float);

  factory CodeType.ofNullableFloat() => CodeType.simple(_float, nullable: true);

  factory CodeType.arrayOfFloat() => CodeType.array(_float);

  factory CodeType.listOfFloat() => CodeType.list(_float);

  // --- Double Type

  static const _double = 'double';

  factory CodeType.ofDouble() => CodeType.simple(_double);

  factory CodeType.ofNullableDouble() =>
      CodeType.simple(_double, nullable: true);

  factory CodeType.arrayOfDouble() => CodeType.array(_double);

  factory CodeType.listOfDouble() => CodeType.list(_double);

  // ---------------------------------------------------------------------------
  // Utilities
  // ---------------------------------------------------------------------------

  factory CodeType.simple(String name, {bool nullable}) => CodeType.of(
        name: name,
        nullable: nullable,
      );

  factory CodeType.genericSingle(
    String name,
    String param, {
    bool nullable,
  }) =>
      CodeType.of(
        name: name,
        generic: CodeGenericParamList.of(
          [CodeGenericParam.of(name: param)],
        ),
        nullable: nullable,
      );

  factory CodeType.genericList(
    String name,
    List<String> params, {
    bool nullable,
  }) =>
      CodeType.of(
        name: name,
        generic: CodeGenericParamList.of(
            params?.map((e) => CodeGenericParam.of(name: e))?.toList()),
        nullable: nullable,
      );

  factory CodeType.array(
    String name, {
    bool nullable,
  }) =>
      CodeType.of(
        name: name,
        array: true,
        nullable: nullable,
      );

  factory CodeType.list(
    String name, {
    bool nullable,
  }) =>
      CodeType.genericSingle(
        _list,
        name,
        nullable: nullable,
      );

  factory CodeType.genericSingleArray(String name, String param,
          {bool nullable}) =>
      CodeType.of(
        name: name,
        generic: CodeGenericParamList.of([CodeGenericParam.of(name: param)]),
        array: true,
        nullable: nullable,
      );

  factory CodeType.genericListArray(
    String name,
    List<String> params, {
    bool nullable,
  }) =>
      CodeType.of(
        name: name,
        generic: CodeGenericParamList.of(
            params?.map((e) => CodeGenericParam.of(name: e))?.toList()),
        array: true,
        nullable: nullable,
      );
}
