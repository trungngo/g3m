part of g3.techlab;

class CodeImportListConfig extends CodeConfigNode<CodeImportList> {
  CodeImportListConfig(NodeBuildFunc<CodeImportList> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeImportListConfig.forJavaLike(Node child) =>
      CodeImportListConfig((context, param) {
        final children = param.imports;
        if (children == null || children.isEmpty) {
          return null;
        }

        return Container([
          NewLine(),
          NewLine(),
          Join.notSeparated(children),
        ]);
      }, child);
}

class CodeImportList extends CodeConfigProxyNode<CodeImportList> {
  final List<CodeImport> imports;

  CodeImportList._(this.imports);

  static CodeImportList _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeImportList>(value, (v) {
      final list = parseNodeList<CodeImport>(v, CodeImport._parse);
      if (list != null) return CodeImportList._(list);
      return null;
    }, error: error);
  }

  factory CodeImportList.of(dynamic values) {
    return CodeImportList._parse(values, error: () {
      throw '$values is not a valid field list';
    });
  }
}
