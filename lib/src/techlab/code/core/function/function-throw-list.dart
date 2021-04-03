part of g3.techlab;

class CodeFunctionThrowListConfig
    extends CodeConfigNode<CodeFunctionThrowList> {
  CodeFunctionThrowListConfig(
      NodeBuildFunc<CodeFunctionThrowList> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeFunctionThrowListConfig.ignored(Node child) =>
      CodeFunctionThrowListConfig(null, child);

  factory CodeFunctionThrowListConfig.forJavaLike(Node child) =>
      CodeFunctionThrowListConfig((context, param) {
        final types = param.types;
        if (types == null || types.isEmpty) {
          return null;
        }

        return TextTransform(Join.commaSeparated(types), (s) {
          s = s?.trim();
          if (s?.isNotEmpty == true) s = ' throws ' + s;
          return s;
        });
      }, child);
}

class CodeFunctionThrowList extends CodeConfigProxyNode<CodeFunctionThrowList> {
  final List<CodeFunctionThrow> types;

  CodeFunctionThrowList._(this.types);

  static CodeFunctionThrowList _parse(dynamic value,
      {NodeParseErrorFunc error}) {
    return parseNode<CodeFunctionThrowList>(value, (v) {
      final list =
          parseNodeList<CodeFunctionThrow>(v, CodeFunctionThrow._parse);
      if (list != null) return CodeFunctionThrowList._(list);
      return null;
    }, error: error);
  }

  factory CodeFunctionThrowList.of(dynamic values) {
    return CodeFunctionThrowList._parse(values, error: () {
      throw '$values is not a valid function throw list';
    });
  }
}
