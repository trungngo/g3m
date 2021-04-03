part of g3.techlab;

class CodeArrayLiteralConfig extends CodeConfigNode<CodeArrayLiteral> {
  CodeArrayLiteralConfig(NodeBuildFunc<CodeArrayLiteral> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeArrayLiteralConfig.forXml(Node child) =>
      CodeArrayLiteralConfig.forJavaLike(
        child,
        emptyArray: '',
        openBracket: '\n',
        closeBracket: '\n',
        separator: '',
      );

  factory CodeArrayLiteralConfig.forJavaLike(
    Node child, {
    String emptyArray = '[]',
    String openBracket = '[\n',
    String closeBracket = '\n]',
    String separator = ',\n',
    String prefix,
    bool indent = true,
  }) =>
      CodeArrayLiteralConfig((context, literal) {
        var values = literal.values;
        if (values == null) {
          return CodeNullLiteral();
        } else if (values.isNotEmpty != true) {
          return Text(emptyArray);
        }

        var body = Join.of(
            separator,
            values
                ?.map(
                  (e) => Pad.left(prefix, e),
                )
                ?.toList());

        return Container([
          openBracket,
          values.isNotEmpty ? indent == true ? Indent(body) : body : null,
          closeBracket,
        ]);
      }, child);

  factory CodeArrayLiteralConfig.forYmlLike(Node child) =>
      CodeArrayLiteralConfig.forJavaLike(
        child,
        emptyArray: '',
        openBracket: '',
        closeBracket: '\n',
        separator: '\n',
        prefix: '- ',
      );
}

class CodeArrayLiteral extends CodeConfigProxyNode<CodeArrayLiteral> {
  final Iterable<CodeExpr> values;

  CodeArrayLiteral._(this.values);

  factory CodeArrayLiteral.of(Iterable<dynamic> value) {
    Iterable<CodeExpr> values;

    if (value == null) {
      values = null;
    } else if (value?.isNotEmpty == true) {
      values = value.map((e) => CodeExpr.of(e, acceptNull: true));
    } else {
      values = [];
    }

    return CodeArrayLiteral._(values);
  }

  factory CodeArrayLiteral.empty() {
    return CodeArrayLiteral._([]);
  }
}
