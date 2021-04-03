part of g3.techlab;

class CodeFieldNameConfig extends CodeConfigNode<CodeFieldName> {
  CodeFieldNameConfig(NodeBuildFunc<CodeFieldName> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeFieldNameConfig.of(StringFunc func, Node child) =>
      CodeFieldNameConfig(
          (context, name) => TextTransform(name.name, func), child);

  factory CodeFieldNameConfig.forDartLike(Node child) =>
      CodeFieldNameConfig((context, name) {
        final modifier = name.modifier;
        Node res = TextTransform(name.name, StringFuncs.camel);

        if (modifier?.isPrivate == true ||
            modifier?.isProtected == true ||
            modifier?.isInternal == true) {
          // Add '_' prefix for non public field.
          res = Pad.left('_', res, onlyIfMissing: true);
        }

        return res;
      }, child);

  factory CodeFieldNameConfig.forJavaLike(Node child) {
    return CodeFieldNameConfig((context, name) {
      var func = StringFuncs.camel;
      final modifier = name.modifier;
      if (modifier?.isStatic == true) {
        func = StringFuncs.constant;
      }

      return TextTransform(name.name, func);
    }, child);
  }
}

class CodeFieldName extends CodeConfigProxyNode<CodeFieldName>
    implements _NamedNode {
  @override
  final Node name;

  final CodeModifier modifier;

  CodeFieldName._({
    @required this.name,
    @required this.modifier,
  }) : assert(name != null);

  static CodeFieldName _parse(dynamic value, {NodeParseErrorFunc error}) {
    // Try to parse the input as the enum name itself.
    return parseNode<CodeFieldName>(value, (v) {
      // Try to parse the input as the name expression.
      final name = _parseNameNode(v, error: error);

      // Don't accept null
      if (name == null) return null;
      return CodeFieldName._(
        name: name,
        modifier: null,
      );
    }, error: error);
  }

  factory CodeFieldName.of({
    @required dynamic name,
    bool isOverride,
    bool isPrivate,
    bool isPublic,
    bool isProtected,
    bool isInternal,
    bool isAbstract,
    bool isStatic,
    bool isFinal,
  }) =>
      CodeFieldName._(
        name: _parseNameNode(name, error: () {
          throw '$name is an invalid field name';
        }),
        modifier: CodeModifier(
          isOverride: isOverride,
          isPrivate: isPrivate,
          isPublic: isPublic,
          isProtected: isProtected,
          isInternal: isInternal,
          isStatic: isStatic,
          isFinal: isFinal,
        ),
      );
}
