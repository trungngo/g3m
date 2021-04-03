part of g3.techlab;

class CodeStatementListConfig extends CodeConfigNode<CodeStatementList> {
  CodeStatementListConfig(
      NodeBuildFunc<CodeStatementList> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeStatementListConfig.forJavaLike(Node child) =>
      CodeStatementListConfig((context, param) {
        final list = param.statements;
        if (list == null || list.isEmpty) {
          return null;
        }
        // Finds the nearest container for this comment.
        final container = context.ancestors.firstWhere(
            (e) => e is CodeBlock || e is CodeConstructor,
            orElse: () => null);

        if (container is CodeConstructor) {
          return Container([
            ':\n',
            Indent(Join.of(',\n', list), level: 2),
            ' ',
          ]);
        } else {
          return Join.notSeparated(list);
        }
      }, child);
}

class CodeStatementList extends CodeConfigProxyNode<CodeStatementList> {
  final List<CodeStatement> statements;

  CodeStatementList._(this.statements);

  factory CodeStatementList._parse(
    dynamic value, {
    bool closed,
    NodeParseErrorFunc error,
  }) {
    return parseNode<CodeStatementList>(value, (v) {
      // Try to parse the body as the node list.
      final statements = parseNodeList<CodeStatement>(v, (v) {
        return CodeStatement._parse(v, closed: closed);
      });

      if (statements != null) {
        // Found result.
        return CodeStatementList._(statements);
      }

      return null;
    }, error: error);
  }

  factory CodeStatementList.of(dynamic value, {bool closed}) =>
      CodeStatementList._parse(value, closed: closed, error: () {
        throw 'cannot parse ${value} as statement list';
      });
}
