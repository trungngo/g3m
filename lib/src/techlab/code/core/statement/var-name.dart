part of g3.techlab;

class CodeVarNameConfig extends CodeConfigNode<CodeVarName> {
  CodeVarNameConfig(NodeBuildFunc<CodeVarName> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeVarNameConfig.of(StringFunc func, Node child) =>
      CodeVarNameConfig(
          (context, name) => TextTransform(name.name, func), child);

  factory CodeVarNameConfig.forJavaLike(Node child) =>
      CodeVarNameConfig.of(StringFuncs.camel, child);
}

class CodeVarName extends CodeConfigProxyNode<CodeVarName>
    implements _NamedNode {
  @override
  final Node name;

  CodeVarName._(this.name);

  static CodeVarName _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeVarName>(value, (v) {
      // Try to parse the value as the expression name.
      final name = _parseNameNode(v, error: error);
      if (name == null) return null;
      return CodeVarName._(name);
    }, error: error);
  }

  factory CodeVarName.of(dynamic value) {
    return CodeVarName._parse(value, error: () {
      throw '${value} is not a valid var name.';
    });
  }
}
