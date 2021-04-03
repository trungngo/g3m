part of g3.techlab;

class CodeWhileConfig extends CodeConfigNode<CodeWhile> {
  CodeWhileConfig(NodeBuildFunc<CodeWhile> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeWhileConfig.forJavaLike(
    Node child, {
    String whileKeyword = 'while',
  }) {
    return CodeWhileConfig((context, expr) {
      return CodeExpr.closed(
        Container([
          expr.comment,
          whileKeyword,
          ' (',
          expr.condition,
          ') ',
          CodeBlock._(expr.body),
          '\n'
        ]),
      );
    }, child);
  }
}

class CodeWhile extends CodeConfigProxyNode<CodeWhile> {
  final CodeExpr condition;

  final CodeStatementList body;

  final CodeComment comment;

  CodeWhile._({
    @required this.condition,
    @required this.body,
    this.comment,
  }) : assert(condition != null, 'while condition is required');

  factory CodeWhile.of({
    dynamic condition,
    dynamic body,
    dynamic comment,
  }) =>
      CodeWhile._(
        condition: CodeExpr.of(condition),
        body: CodeStatementList.of(body),
        comment: CodeComment.of(comment),
      );
}
