part of g3.techlab;

class CodeClassListConfig extends CodeConfigNode<CodeClassList> {
  CodeClassListConfig(NodeBuildFunc<CodeClassList> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeClassListConfig.forJavaLike(Node child) =>
      CodeClassListConfig((context, param) {
        final children = param.classes;
        if (children == null || children.isEmpty) {
          return null;
        }

        return Container([
          NewLine(),
          NewLine(),
          Join.newLineSeparated(children),
        ]);
      }, child);
}

class CodeClassList extends CodeConfigProxyNode<CodeClassList> {
  final List<CodeClass> classes;

  CodeClassList._(this.classes);

  static CodeClassList _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeClassList>(value, (v) {
      final list = parseNodeList<CodeClass>(v, null);
      if (list != null) return CodeClassList._(list);
      return null;
    }, error: error);
  }

  factory CodeClassList.of(dynamic values) {
    return CodeClassList._parse(values, error: () {
      throw '$values is not a valid class list';
    });
  }
}
