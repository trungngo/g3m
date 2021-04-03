part of g3.techlab;

class CodeArgListConfig extends CodeConfigNode<CodeArgList> {
  CodeArgListConfig(NodeBuildFunc<CodeArgList> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeArgListConfig.forDartLike(Node child) =>
      CodeArgListConfig._internal(child, isDart: true);

  factory CodeArgListConfig.forJavaLike(Node child) =>
      CodeArgListConfig._internal(child);

  factory CodeArgListConfig._internal(
    Node child, {
    bool isDart = false,
  }) =>
      CodeArgListConfig((context, expr) {
        bool hasAnnotation(List<CodeArg> list) {
          if (list?.isNotEmpty != true) return false;

          final first = list.firstWhere((e) {
            return e?.annotations?.annotations?.isNotEmpty == true;
          }, orElse: () => null);

          return first != null;
        }

        final required = expr.required;
        final optional = expr.optional;
        final named = expr.named;
        final count = (required?.length ?? 0) +
            (optional?.length ?? 0) +
            (named?.length ?? 0);

        final needNewLine = count > 4 ||
            hasAnnotation(required) ||
            hasAnnotation(optional) ||
            hasAnnotation(named);

        final separator = needNewLine ? ',\n' : ', ';

        Node requiredNode =
            required?.isNotEmpty == true ? Join.of(separator, required) : null;

        Node optionalNode =
            optional?.isNotEmpty == true ? Join.of(separator, optional) : null;

        Node namedNode =
            named?.isNotEmpty == true ? Join.of(separator, named) : null;

        final args = <Node>[];

        if (requiredNode != null) {
          args.add(requiredNode);
        }

        if (optionalNode != null) {
          if (isDart == true) optionalNode = Pad.squareBrackets(optionalNode);
          args.add(optionalNode);
        }

        if (namedNode != null) {
          if (isDart == true) namedNode = Pad.curlyBrackets(namedNode);
          args.add(namedNode);
        }

        if (needNewLine) {
          return Container([
            NewLine(),
            Indent(Join.commaNewLineSeparated(args)),
          ]);
        } else {
          return Join.commaSeparated(args);
        }
      }, child);
}

class CodeArgList extends CodeConfigProxyNode<CodeArgList> {
  /// The list of required arguments.
  final List<CodeArg> required;

  /// The list of positioned arguments.
  final List<CodeArg> optional;

  /// The list of named arguments.
  final List<CodeArg> named;

  CodeArgList._({this.required, this.optional, this.named});

  factory CodeArgList.of({
    dynamic required,
    dynamic optional,
    dynamic named,
  }) {
    return CodeArgList._(
      required: parseNodeList<CodeArg>(required, CodeArg._parse),
      optional: parseNodeList<CodeArg>(optional, CodeArg._parse),
      named: parseNodeList<CodeArg>(named, CodeArg._parse),
    );
  }
}
