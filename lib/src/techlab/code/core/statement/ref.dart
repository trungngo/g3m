part of g3.techlab;

class CodeRefConfig extends CodeConfigNode<CodeRef> {
  CodeRefConfig(NodeBuildFunc<CodeRef> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeRefConfig.forJavaLike(Node child) =>
      CodeRefConfig((context, expr) {
        return expr.name;
      }, child);
}

class CodeRef extends CodeConfigProxyNode<CodeRef> implements _NamedNode {
  @override
  final Node name;

  CodeRef._(this.name) : assert(name != null);

  static CodeRef _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeRef>(value, (v) {
      Node name;
      if (v is CodeField ||
          v is CodeVar ||
          v is CodeProperty ||
          v is CodeConstructor ||
          v is CodeFunction) {
        // refers the name field (but not the internal name)
        // so that the value is case sensitive.
        name = v.name;
      } else {
        // Try to parse the value as the expression name.
        name = _parseNameNode(v, error: error);
      }
      if (name == null) return null;
      return CodeRef._(name);
    }, error: error);
  }

  factory CodeRef.of(dynamic value) {
    return CodeRef._parse(value, error: () {
      throw '${value} is not a valid name.';
    });
  }

  factory CodeRef.ofThis() => CodeRef._(Text('this'));

  factory CodeRef.ofSuper() => CodeRef._(Text('super'));
}
