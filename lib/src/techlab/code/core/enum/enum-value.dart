part of g3.techlab;

class CodeEnumValueConfig extends CodeConfigNode<CodeEnumValue> {
  CodeEnumValueConfig(NodeBuildFunc<CodeEnumValue> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeEnumValueConfig.forJavaLike(Node child) =>
      CodeEnumValueConfig((context, field) {
        return Container([
          field.comment,
          field.name,
          field.init != null ? Container([' = ', field.init]) : null,
        ]);
      }, child);
}

class CodeEnumValue extends CodeConfigProxyNode<CodeEnumValue>
    implements _NamedNode {
  @override
  final CodeEnumValueName name;

  final CodeExpr init;

  final CodeComment comment;

  CodeEnumValue._({
    this.name,
    this.init,
    this.comment,
  });

  static CodeEnumValue _parse(dynamic value, {NodeParseErrorFunc error}) {
    // Try to parse the input as the enum name itself.
    return parseNode<CodeEnumValue>(value, (v) {
      final list = _toDynamicNodeList(value);
      if (list?.isNotEmpty != true) return null;

      // Try to parse the input as the name expression.
      final name = CodeEnumValueName._parse(list[0]);
      // Don't accept null
      if (name == null) return null;

      final init =
          list.length > 1 ? CodeExpr._parse(list[1], error: error) : null;

      final comment =
          list.length > 2 ? CodeComment._parse(list[2], error: error) : null;

      return CodeEnumValue._(
        name: name,
        init: init,
        comment: comment,
      );
    }, error: error);
  }

  factory CodeEnumValue.of({
    @required dynamic name,
    dynamic init,
    dynamic comment,
    bool isPrivate,
  }) {
    return CodeEnumValue._(
      name: CodeEnumValueName.of(
        name: name,
        isPrivate: isPrivate,
      ),
      init: CodeExpr.of(init),
      comment: CodeComment.of(comment),
    );
  }
}
