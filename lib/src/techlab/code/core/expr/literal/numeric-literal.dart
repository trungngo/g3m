part of g3.techlab;

class CodeNumericLiteralConfig extends CodeConfigNode<CodeNumericLiteral> {
  CodeNumericLiteralConfig(
      NodeBuildFunc<CodeNumericLiteral> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeNumericLiteralConfig.forJavaLike(Node child) =>
      CodeNumericLiteralConfig((context, literal) {
        if (literal.value == null) return CodeNullLiteral();
        return Text(literal.value);
      }, child);
}

class CodeNumericLiteral extends CodeConfigProxyNode<CodeNumericLiteral> {
  final num value;

  CodeNumericLiteral._(this.value);

  factory CodeNumericLiteral.of(num value) => CodeNumericLiteral._(value);
}
