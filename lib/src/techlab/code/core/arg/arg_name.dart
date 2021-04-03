part of g3.techlab;

class CodeArgNameConfig extends CodeConfigNode<CodeArgName> {
  CodeArgNameConfig(NodeBuildFunc<CodeArgName> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeArgNameConfig.forJavaLike(Node child) =>
      CodeArgNameConfig._internal(child);

  factory CodeArgNameConfig.forDartLike(Node child) =>
      CodeArgNameConfig._internal(child, privatePrefix: '_');

  factory CodeArgNameConfig._internal(
    Node child, {
    StringFunc func,
    String privatePrefix = '',
  }) {
    func ??= StringFuncs.camel;
    return CodeArgNameConfig((_, arg) {
      return Container([
        arg.isPrivate == true ? privatePrefix : null,
        TextTransform(arg.name, func),
      ]);
    }, child);
  }
}

class CodeArgName extends CodeConfigProxyNode<CodeArgName>
    implements _NamedNode {
  @override
  final Node name;

  /// True indicates this field name is private.
  final bool isPrivate;

  CodeArgName._({
    @required this.name,
    @required this.isPrivate,
  });

  static CodeArgName _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeArgName>(value, (v) {
      // Try to parse the value as the expression name.
      final name = _parseNameNode(v, error: error);
      if (name == null) return null;
      return CodeArgName._(
        name: name,
        isPrivate: null,
      );
    }, error: error);
  }

  factory CodeArgName.of({
    @required dynamic name,
    bool isPrivate,
  }) {
    return CodeArgName._(
      name: _parseNameNode(name, error: () {
        throw '$name is an invalid arg name';
      }),
      isPrivate: isPrivate,
    );
  }
}
