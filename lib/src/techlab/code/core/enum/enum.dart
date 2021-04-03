part of g3.techlab;

class CodeEnumConfig extends CodeConfigNode<CodeEnum> {
  CodeEnumConfig(NodeBuildFunc<CodeEnum> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeEnumConfig.forJavaLike(
    Node child, {
    String enumKeyword = 'enum ',
  }) =>
      CodeEnumConfig((context, def) {
        Node valuesAndBody = def.values;

        if (valuesAndBody == null) {
          valuesAndBody = def.body;
        } else if (def.body != null) {
          valuesAndBody = Container([
            valuesAndBody,
            ';\n',
            def.body,
          ]);
        }
        valuesAndBody = CodeBlock._(valuesAndBody);

        return Container([
          '\n',
          def.comment,
          Trim.leftRight(
            Container([
              def.modifier,
              enumKeyword,
              def.name,
            ]),
          ),
          ' ',
          valuesAndBody,
          '\n',
        ]);
      }, child);
}

class CodeEnum extends CodeConfigProxyNode<CodeEnum> implements _NamedNode {
  /// The class name.
  @override
  final CodeEnumName name;

  /// Defines public, private, protected, etc.
  final CodeModifier modifier;

  /// Enum-level code comment.
  final CodeComment comment;

  final CodeEnumValueList values;

  final CodeStatementList body;

  CodeEnum._({
    @required this.name,
    this.modifier,
    this.comment,
    this.values,
    this.body,
  }) : assert(name != null);

  static CodeEnum _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeEnum>(value, (v) {
      final list = _toDynamicNodeList(value);
      if (list?.isNotEmpty != true) return null;

      // allows enum to be parsed in as an array of values
      final name = CodeEnumName._parse(list[0]);
      if (name != null && list.length > 1) {
        // Continues parsing the initializers
        final values = CodeEnumValueList._parse(list.sublist(1));
        return CodeEnum._(name: name, values: values);
      }

      return null;
    }, error: error);
  }

  /// Creates an element that models a "enum" language construct.
  /// [name] defines the enum element. The
  /// any
  ///
  /// No more than one of [isPrivate], [isPublic], [isProtected], or [isInternal]
  /// modifier should be used.
  ///
  /// [values] is the list of [CodeEnumValue]. Each enum value must
  /// have a name, and optional value, comment.
  ///
  /// [body] is the class-like implementation for the enum.
  /// Some language like Kotlin allow this.
  ///
  /// Long-form usage:
  ///
  /// CodeEnum.of(
  ///   name: CodeValueName.of('),
  /// )
  ///
  factory CodeEnum.of({
    dynamic name,
    bool isPrivate,
    bool isPublic,
    bool isProtected,
    bool isInternal,
    dynamic values,
    dynamic comment,
    dynamic body,
  }) {
    return CodeEnum._(
      name: CodeEnumName.of(
        name: name,
        isPrivate: isPrivate,
      ),
      modifier: CodeModifier(
        isPrivate: isPrivate,
        isPublic: isPublic,
        isProtected: isProtected,
        isInternal: isInternal,
      ),
      values: CodeEnumValueList.of(values),
      comment: CodeComment.of(comment),
      body: CodeStatementList.of(body),
    );
  }
}
