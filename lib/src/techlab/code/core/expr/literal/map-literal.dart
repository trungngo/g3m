part of g3.techlab;

class CodeMapLiteralConfig extends CodeConfigNode<CodeMapLiteral> {
  CodeMapLiteralConfig(NodeBuildFunc<CodeMapLiteral> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeMapLiteralConfig.forXml(Node child) =>
      CodeMapLiteralConfig((context, literal) {
        if (literal.values == null) return CodeNullLiteral();
        var pairs = literal.values.entries.map(
          (e) {
            final k = e.key;
            return Container([
              '<',
              k,
              '>',
              e.value,
              '</',
              k,
              '>',
            ]);
          },
        ).toList();

        return Container([
          literal.values.isNotEmpty
              ? Container([
                  NewLine(),
                  Indent(Join.newLineSeparated(pairs)),
                  NewLine(),
                ])
              : null,
        ]);
      }, child);

  factory CodeMapLiteralConfig.forJavaLike(
    Node child, {
    String openBracket = '{',
    String closeBracket = '}',
    String quote = '"',
    String separator = ': ',
  }) =>
      CodeMapLiteralConfig((context, literal) {
        if (literal.values == null) return CodeNullLiteral();
        var pairs = literal.values.entries.map(
          (e) {
            final k = e.key;
            return Container([k, separator, e.value]);
          },
        ).toList();
        return Container([
          openBracket,
          literal.values.isNotEmpty
              ? Container([
                  '\n',
                  Indent(Join.of(',\n', pairs)),
                  '\n',
                ])
              : null,
          closeBracket,
        ]);
      }, child);

  factory CodeMapLiteralConfig.forYmlLike(
    Node child, {
    String separator = ': ',
  }) =>
      CodeMapLiteralConfig((context, literal) {
        final config = IndentConfig.of(context);

        if (literal.values == null) return CodeNullLiteral();
        var pairs = literal.values.entries.map(
          (e) {
            return Container([
              e.key,
              separator,
              TextTransform(e.value, (s) {
                if (s?.contains('\n') == true) {
                  return '\n' +
                      Indent.compute(s, config.useTab, config.size, 1);
                }
                return s;
              }),
            ]);
          },
        ).toList();

        return literal.values.isNotEmpty
            ? Container([
                Join.of('\n', pairs),
                NewLine(),
              ])
            : null;
      }, child);
}

class CodeMapLiteral extends CodeConfigProxyNode<CodeMapLiteral> {
  final Map<CodeExpr, CodeExpr> values;

  CodeMapLiteral._(this.values);

  factory CodeMapLiteral.of(Map<dynamic, dynamic> values) {
    if (values == null) return CodeMapLiteral._(null);

    final res = <CodeExpr, CodeExpr>{};

    for (final e in values.entries) {
      res[CodeExpr.of(e.key)] = CodeExpr.of(e.value, acceptNull: true);
    }

    return CodeMapLiteral._(res);
  }
}
