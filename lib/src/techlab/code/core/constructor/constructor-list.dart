part of g3.techlab;

class CodeConstructorListConfig extends CodeConfigNode<CodeConstructorList> {
  CodeConstructorListConfig(
      NodeBuildFunc<CodeConstructorList> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeConstructorListConfig.forJavaLike(Node child) =>
      CodeConstructorListConfig((context, param) {
        final children = param.constructors;
        if (children == null || children.isEmpty) {
          return null;
        }

        return Container([
          '\n',
          Join.newLineSeparated(children),
        ]);
      }, child);
}

class CodeConstructorList extends CodeConfigProxyNode<CodeConstructorList> {
  final List<CodeConstructor> constructors;

  CodeConstructorList._(this.constructors);

  static CodeConstructorList _parse(dynamic value,
      {NodeParseErrorFunc error}) {
    return parseNode<CodeConstructorList>(value, (v) {
      final list = parseNodeList<CodeConstructor>(v, null);
      if (list != null) return CodeConstructorList._(list);
      return null;
    }, error: error);
  }

  factory CodeConstructorList.of(dynamic values) {
    return CodeConstructorList._parse(values, error: () {
      throw '$values is not a valid constructor list';
    });
  }
}
