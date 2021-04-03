part of g3.techlab;

class CodeAnnotationListConfig extends CodeConfigNode<CodeAnnotationList> {
  CodeAnnotationListConfig(
      NodeBuildFunc<CodeAnnotationList> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeAnnotationListConfig.forJavaLike(Node child) =>
      CodeAnnotationListConfig((context, param) {
        if (param.annotations?.isNotEmpty != true) return null;
        final isInArg = context.findAncestorNodeOfExactType<CodeArg>() != null;
        if (isInArg) {
          return Container([
            Join.spaceSeparated(param.annotations),
            ' ',
          ]);
        } else {
          return Container([
            Join.newLineSeparated(param.annotations),
            '\n',
          ]);
        }
      }, child);
}

class CodeAnnotationList extends CodeConfigProxyNode<CodeAnnotationList> {
  final List<CodeAnnotation> annotations;

  CodeAnnotationList._(this.annotations);

  static CodeAnnotationList _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeAnnotationList>(value, (v) {
      final list =
          parseNodeList<CodeAnnotation>(v, (v) => CodeAnnotation.of(v));
      if (list != null) return CodeAnnotationList._(list);
      return null;
    }, error: error);
  }

  factory CodeAnnotationList.of(dynamic values) {
    return CodeAnnotationList._parse(values, error: () {
      throw '$values is not a valid annotation value list';
    });
  }
}
