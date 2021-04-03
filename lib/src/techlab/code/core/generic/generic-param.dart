part of g3.techlab;

class CodeGenericParamConfig extends CodeConfigNode<CodeGenericParam> {
  CodeGenericParamConfig(NodeBuildFunc<CodeGenericParam> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeGenericParamConfig.forJavaLike(Node child) =>
      CodeGenericParamConfig((context, param) {
        return param.name;
      }, child);
}

class CodeGenericParam extends CodeConfigProxyNode<CodeGenericParam>
    implements _NamedNode {
  @override
  final CodeType name;

  CodeGenericParam._({@required this.name})
      : assert(name != null);

  static CodeGenericParam _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeGenericParam>(value, (v) {
      // Try to parse the value as the expression name.
      final name = CodeType._parse(v, error: error);
      if (name == null) return null;
      return CodeGenericParam._(
        name: name,
      );
    }, error: error);
  }

  factory CodeGenericParam.of({
    @required dynamic name,
  }) {
    return CodeGenericParam._(
      name: CodeType._parse(name),
    );
  }
}
