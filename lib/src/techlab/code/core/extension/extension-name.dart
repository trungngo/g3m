part of g3.techlab;

class CodeExtensionNameConfig extends CodeConfigNode<CodeExtensionName> {
  CodeExtensionNameConfig(
      NodeBuildFunc<CodeExtensionName> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeExtensionNameConfig.of(StringFunc func, Node child) =>
      CodeExtensionNameConfig(
          (context, name) => TextTransform(name.name, func), child);

  factory CodeExtensionNameConfig.forDartLike(Node child) =>
      CodeExtensionNameConfig((context, name) {
        final clazz = context.findAncestorNodeOfExactType<CodeExtension>();
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

class CodeExtensionName extends CodeConfigProxyNode<CodeExtensionName>
    implements _NamedNode {
  @override
  final Node name;

  CodeExtensionName._(this.name);

  static CodeExtensionName _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeExtensionName>(value, (v) {
      // Try to parse the value as the expression name.
      final name = _parseNameNode(v, error: error);
      if (name == null) return null;
      return CodeExtensionName._(name);
    }, error: error);
  }

  factory CodeExtensionName.of(dynamic value) {
    return CodeExtensionName._parse(value, error: () {
      throw '${value} is not a valid extension name.';
    });
  }
}
