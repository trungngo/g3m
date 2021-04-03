part of g3.techlab;

class CodeFunctionNameConfig extends CodeConfigNode<CodeFunctionName> {
  CodeFunctionNameConfig(NodeBuildFunc<CodeFunctionName> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeFunctionNameConfig.of(StringFunc func, Node child) =>
      CodeFunctionNameConfig(
          (context, name) => TextTransform(name.name, func), child);

  factory CodeFunctionNameConfig.forJavaLike(Node child) =>
      CodeFunctionNameConfig.of(StringFuncs.camel, child);

  factory CodeFunctionNameConfig.forDartLike(Node child) =>
      CodeFunctionNameConfig((context, name) {
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
}

class CodeFunctionName extends CodeConfigProxyNode<CodeFunctionName>
    implements _NamedNode {
  @override
  final Node name;

  final CodeModifier modifier;

  CodeFunctionName._({
    @required this.name,
    this.modifier,
  }) : assert(name != null);

  static CodeFunctionName _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeFunctionName>(value, (v) {
      // Try to parse the value as the expression name.
      final name = _parseNameNode(v, error: error);
      if (name == null) return null;
      return CodeFunctionName._(name: name, modifier: null);
    }, error: error);
  }

  factory CodeFunctionName.of({
    dynamic name,
    bool isOverride,
    bool isPrivate,
    bool isPublic,
    bool isProtected,
    bool isInternal,
    bool isAbstract,
    bool isStatic,
  }) {
    return CodeFunctionName._(
      name: _parseNameNode(name, error: () {
        throw '$name is an invalid function name';
      }),
      modifier: CodeModifier(
        isOverride: isOverride,
        isPrivate: isPrivate,
        isPublic: isPublic,
        isProtected: isProtected,
        isInternal: isInternal,
        isAbstract: isAbstract,
        isStatic: isStatic,
      ),
    );
  }
}
