part of g3.techlab;

class CodeElseIfConfig extends CodeConfigNode<CodeElseIf> {
  CodeElseIfConfig(NodeBuildFunc<CodeElseIf> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeElseIfConfig.forJavaLike(
    Node child, {
    String ifKeyword = 'if',
    String elseKeyword = 'else',
  }) =>
      CodeElseIfConfig((context, expr) {
        return Container([
          expr.comment ?? ' ',
          elseKeyword,
          ' ',
          ifKeyword,
          ' (',
          expr.condition,
          ') ',
          CodeBlock.of(expr.then),
        ]);
      }, child);
}

class CodeElseIf extends CodeConfigProxyNode<CodeElseIf> {
  final CodeExpr condition;
  final CodeStatementList then;
  final CodeComment comment;

  CodeElseIf._({
    @required this.condition,
    @required this.then,
    this.comment,
  })  : assert(
            condition != null, 'condition is required for else if statement.'),
        assert(then != null, 'then block is required for else if statement.');

  /// Try parse a dynamic value to an argument object.
  static List<CodeElseIf> _parseList(dynamic value,
      {NodeParseErrorFunc error}) {
    return parseNode<List<CodeElseIf>>(value, (v) {
      return parseNodeList<CodeElseIf>(v, (v) {
        return CodeElseIf._parse(v);
      });
    }, error: error);
  }

  static CodeElseIf _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeElseIf>(value, null, error: error);
  }

  factory CodeElseIf.of({
    @required dynamic condition,
    @required dynamic then,
    dynamic comment,
  }) {
    if (condition == null && then == null && comment == null) {
      return null;
    }

    return CodeElseIf._(
      condition: CodeExpr.of(condition),
      then: CodeStatementList.of(then),
      comment: CodeComment.of(comment),
    );
  }
}
