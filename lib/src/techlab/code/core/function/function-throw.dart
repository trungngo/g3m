part of g3.techlab;

class CodeFunctionThrowConfig extends CodeConfigNode<CodeFunctionThrow> {
  CodeFunctionThrowConfig(
      NodeBuildFunc<CodeFunctionThrow> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeFunctionThrowConfig.ignored(Node child) =>
      CodeFunctionThrowConfig(null, child);

  factory CodeFunctionThrowConfig.forJavaLike(Node child) =>
      CodeFunctionThrowConfig((context, funcThrow) {
        return funcThrow.type;
      }, child);
}

class CodeFunctionThrow extends CodeConfigProxyNode<CodeFunctionThrow> {
  final CodeType type;

  CodeFunctionThrow._({this.type});

  /// Try parse a dynamic value to an argument object.
  static CodeFunctionThrow _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeFunctionThrow>(value, (v) {
      final list = _toDynamicNodeList(v);

      if (list?.isNotEmpty != true || list.length > 1) {
        return null;
      }

      // Try to parse the input as the name expression.
      final type = CodeType._parse(list[0], error: error);

      return CodeFunctionThrow._(type: type);
    }, error: error);
  }

  factory CodeFunctionThrow.of({
    @required dynamic type,
  }) {
    return CodeFunctionThrow._(
        type: CodeType._parse(type, error: () {
      throw '$type is an invalid function throw type';
    }));
  }
}
