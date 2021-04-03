part of g3.techlab;

class CodeMixinNameConfig extends CodeConfigNode<CodeMixinName> {
  CodeMixinNameConfig(NodeBuildFunc<CodeMixinName> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeMixinNameConfig.of(StringFunc func, Node child) =>
      CodeMixinNameConfig(
          (context, name) => TextTransform(name.name, func), child);

  factory CodeMixinNameConfig.forDartLike(Node child) =>
      CodeMixinNameConfig((context, name) {
        final clazz = context.findAncestorNodeOfExactType<CodeMixin>();
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

class CodeMixinName extends CodeConfigProxyNode<CodeMixinName>
    implements _NamedNode {
  @override
  final Node name;

  CodeMixinName._(this.name);

  static CodeMixinName _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeMixinName>(value, (v) {
      // Try to parse the value as the expression name.
      final name = _parseNameNode(v, error: error);
      if (name == null) return null;
      return CodeMixinName._(name);
    }, error: error);
  }

  factory CodeMixinName.of(dynamic value) {
    return CodeMixinName._parse(value, error: () {
      throw '${value} is not a valid mixin name.';
    });
  }
}
