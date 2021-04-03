part of g3.techlab;

class CodeFunctionReturnListConfig
    extends CodeConfigNode<CodeFunctionReturnList> {
  CodeFunctionReturnListConfig(
      NodeBuildFunc<CodeFunctionReturnList> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeFunctionReturnListConfig.forJavaLike(Node child) =>
      CodeFunctionReturnListConfig((context, param) {
        final types = param.types;
        if (types == null || types.isEmpty) {
          return null;
        }

        return Join.commaSeparated(types);
      }, child);
}

class CodeFunctionReturnList
    extends CodeConfigProxyNode<CodeFunctionReturnList> {
  final List<CodeFunctionReturn> types;

  CodeFunctionReturnList._(this.types);

  static CodeFunctionReturnList _parse(dynamic value,
      {NodeParseErrorFunc error}) {
    return parseNode<CodeFunctionReturnList>(value, (v) {
      var list =
          parseNodeList<CodeFunctionReturn>(v, CodeFunctionReturn._parse);

      // Try to parse the type from a type list
      if (list == null) {
        final typeList = CodeTypeList.of(value);
        // converts the type list to the function return list.
        if (typeList != null) {
          list = typeList.types.map((t) {
            return CodeFunctionReturn.of(type: t);
          });
        }
      }

      if (list != null) return CodeFunctionReturnList._(list);

      return null;
    }, error: error);
  }

  factory CodeFunctionReturnList.of(dynamic values) {
    return CodeFunctionReturnList._parse(values, error: () {
      throw '$values is not a valid function return list';
    });
  }
}
