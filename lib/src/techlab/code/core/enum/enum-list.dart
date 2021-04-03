part of g3.techlab;

class CodeEnumListConfig extends CodeConfigNode<CodeEnumList> {
  CodeEnumListConfig(NodeBuildFunc<CodeEnumList> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeEnumListConfig.forJavaLike(Node child) =>
      CodeEnumListConfig((context, param) {
        final children = param.enums;
        if (children == null || children.isEmpty) {
          return null;
        }

        return Container([
          '\n',
          Join.newLineSeparated(children),
        ]);
      }, child);
}

class CodeEnumList extends CodeConfigProxyNode<CodeEnumList> {
  final List<CodeEnum> enums;

  CodeEnumList._(this.enums);

  static CodeEnumList _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeEnumList>(value, (v) {
      final list = parseNodeList<CodeEnum>(v, CodeEnum._parse);
      if (list != null) return CodeEnumList._(list);
      return null;
    }, error: error);
  }

  factory CodeEnumList.of(dynamic values) {
    return CodeEnumList._parse(values, error: () {
      throw '$values is not a valid enum value list';
    });
  }
}
