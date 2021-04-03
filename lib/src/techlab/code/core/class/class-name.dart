part of g3.techlab;

class CodeClassNameConfig extends CodeConfigNode<CodeClassName> {
  CodeClassNameConfig(NodeBuildFunc<CodeClassName> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeClassNameConfig.of(StringFunc func, Node child) =>
      CodeClassNameConfig(
          (context, name) => TextTransform(name.name, func), child);

  factory CodeClassNameConfig.forJavaLike(Node child) =>
      CodeClassNameConfig.of(StringFuncs.pascal, child);

  factory CodeClassNameConfig.forDartLike(Node child) =>
      CodeClassNameConfig((context, name) {
        final clazz = context.findAncestorNodeOfExactType<CodeClass>();
        final modifier = clazz?.modifier;

        Node res = TextTransform(name.name, StringFuncs.pascal);

        if (modifier?.isPrivate == true ||
            modifier?.isProtected == true ||
            modifier?.isInternal == true) {
          // Add '_' prefix for non public clazz.
          res = Pad.left('_', res, onlyIfMissing: true);
        }

        return res;
      }, child);
}

class CodeClassName extends CodeConfigProxyNode<CodeClassName>
    implements _NamedNode {
  @override
  final Node name;

  CodeClassName._(this.name);

  static CodeClassName _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeClassName>(value, (v) {
      // Try to parse the value as the expression name.
      final name = _parseNameNode(v, error: error);
      if (name == null) return null;
      return CodeClassName._(name);
    }, error: error);
  }

  factory CodeClassName.of(dynamic value) {
    return CodeClassName._parse(value, error: () {
      throw '${value} is not a valid class name.';
    });
  }
}
