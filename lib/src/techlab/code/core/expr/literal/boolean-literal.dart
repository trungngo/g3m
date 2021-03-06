part of g3.techlab;

class CodeBoolLiteralConfig extends CodeConfigNode<CodeBoolLiteral> {
  CodeBoolLiteralConfig(NodeBuildFunc<CodeBoolLiteral> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeBoolLiteralConfig.forJavaLike(
    Node child, {
    String trueKeyword = 'true',
    String falseKeyword = 'false',
  }) =>
      CodeBoolLiteralConfig((context, literal) {
        if (literal.value == null) return CodeNullLiteral();
        if (literal.value == true) return Text(trueKeyword);
        return Text(falseKeyword);
      }, child);
}

class CodeBoolLiteral extends CodeConfigProxyNode<CodeBoolLiteral> {
  final bool value;

  CodeBoolLiteral._(this.value);

  factory CodeBoolLiteral.of(bool value) => CodeBoolLiteral._(value);
}
