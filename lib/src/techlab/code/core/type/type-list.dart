part of g3.techlab;

class CodeTypeListConfig extends CodeConfigNode<CodeTypeList> {
  CodeTypeListConfig(NodeBuildFunc<CodeTypeList> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeTypeListConfig.forJavaLike(Node child) =>
      CodeTypeListConfig((context, param) {
        final children = param.types;
        if (children == null || children.isEmpty) {
          return null;
        }

        return Join.commaSeparated(children);
      }, child);
}

class CodeTypeList extends CodeConfigProxyNode<CodeTypeList> {
  final List<CodeType> types;

  CodeTypeList._(this.types);

  static CodeTypeList _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeTypeList>(value, (v) {
      final list = parseNodeList<CodeType>(v, CodeType._parse);
      if (list != null) return CodeTypeList._(list);
      return null;
    }, error: error);
  }

  factory CodeTypeList.of(dynamic values) {
    return CodeTypeList._parse(values, error: () {
      throw '$values is not a valid type list';
    });
  }
}
