part of g3.techlab;

class CodeNullLiteralConfig extends CodeConfigNode<CodeNullLiteral> {
  CodeNullLiteralConfig(NodeBuildFunc<CodeNullLiteral> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeNullLiteralConfig.forXml(Node child) =>
      CodeNullLiteralConfig.forJavaLike(child, nullKeyword: '');

  factory CodeNullLiteralConfig.forJavaLike(
    Node child, {
    String nullKeyword = 'null',
  }) =>
      CodeNullLiteralConfig((context, package) {
        return Text(nullKeyword);
      }, child);
}

class CodeNullLiteral extends CodeConfigProxyNode<CodeNullLiteral> {}
