part of g3.techlab;

class CodeMixinListConfig extends CodeConfigNode<CodeMixinList> {
  CodeMixinListConfig(NodeBuildFunc<CodeMixinList> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeMixinListConfig.forDartLike(Node child) =>
      CodeMixinListConfig((context, param) {
        final children = param.mixins;
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

class CodeMixinList extends CodeConfigProxyNode<CodeMixinList> {
  final List<CodeMixin> mixins;

  CodeMixinList._(this.mixins);

  static CodeMixinList _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeMixinList>(value, (v) {
      final list = parseNodeList<CodeMixin>(v, null);
      if (list != null) return CodeMixinList._(list);
      return null;
    }, error: error);
  }

  factory CodeMixinList.of(dynamic values) {
    return CodeMixinList._parse(values, error: () {
      throw '$values is not a valid mixin list';
    });
  }
}
