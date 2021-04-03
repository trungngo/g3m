part of g3.techlab;

class CodeExtensionListConfig extends CodeConfigNode<CodeExtensionList> {
  CodeExtensionListConfig(
      NodeBuildFunc<CodeExtensionList> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeExtensionListConfig.forDartLike(Node child) =>
      CodeExtensionListConfig((context, param) {
        final children = param.extensions;
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

class CodeExtensionList extends CodeConfigProxyNode<CodeExtensionList> {
  final List<CodeExtension> extensions;

  CodeExtensionList._(this.extensions);

  static CodeExtensionList _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeExtensionList>(value, (v) {
      final list = parseNodeList<CodeExtension>(v, null);
      if (list != null) return CodeExtensionList._(list);
      return null;
    }, error: error);
  }

  factory CodeExtensionList.of(dynamic values) {
    return CodeExtensionList._parse(values, error: () {
      throw '$values is not a valid extension list';
    });
  }
}
