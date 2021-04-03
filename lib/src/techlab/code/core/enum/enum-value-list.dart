part of g3.techlab;

class CodeEnumValueListConfig extends CodeConfigNode<CodeEnumValueList> {
  CodeEnumValueListConfig(
      NodeBuildFunc<CodeEnumValueList> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeEnumValueListConfig.forJavaLike(Node child) =>
      CodeEnumValueListConfig((context, param) {
        final children = param.args;
        if (children == null || children.isEmpty) {
          return null;
        }
        return Join.of(',\n', children);
      }, child);
}

class CodeEnumValueList extends CodeConfigProxyNode<CodeEnumValueList> {
  final List<CodeEnumValue> args;

  CodeEnumValueList._(this.args);

  static CodeEnumValueList _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeEnumValueList>(value, (v) {
      final list = parseNodeList<CodeEnumValue>(v, CodeEnumValue._parse);
      if (list != null) return CodeEnumValueList._(list);
      return null;
    }, error: error);
  }

  factory CodeEnumValueList.of(dynamic values) {
    return CodeEnumValueList._parse(values, error: () {
      throw '$values is not a valid enum value list';
    });
  }
}
