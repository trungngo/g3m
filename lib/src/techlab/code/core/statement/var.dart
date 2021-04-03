part of g3.techlab;

class CodeVarConfig extends CodeConfigNode<CodeVar> {
  CodeVarConfig(NodeBuildFunc<CodeVar> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeVarConfig.forJava(
      Node child,
      ) =>
      CodeVarConfig._internal(
        child,
        varKeyword: null,
        finalKeyword: 'final ',
        typeNameSeparator: ' ',
        typeFirst: true,
      );

  factory CodeVarConfig.forTypescript(
    Node child,
  ) =>
      CodeVarConfig._internal(
        child,
        varKeyword: 'let ',
        finalKeyword: 'const ',
        typeNameSeparator: ': ',
        typeFirst: false,
      );

  factory CodeVarConfig.forKotlin(
    Node child,
  ) =>
      CodeVarConfig._internal(
        child,
        varKeyword: 'var ',
        finalKeyword: 'val ',
        typeNameSeparator: ': ',
        typeFirst: false,
      );

  factory CodeVarConfig.forDartLike(
    Node child,
  ) =>
      CodeVarConfig._internal(
        child,
        varKeyword: null,
        finalKeyword: 'final ',
        typeNameSeparator: ' ',
        typeFirst: true,
      );

  factory CodeVarConfig._internal(
    Node child, {
    @required String varKeyword,
    @required String finalKeyword,
    @required String typeNameSeparator,
    @required bool typeFirst,
  }) =>
      CodeVarConfig((context, expr) {
        Node s1 = expr.name;
        Node s2 = expr.type;

        if (typeFirst == true) {
          // swap
          var tmp = s1;
          s1 = s2;
          s2 = tmp;
        }

        Node typeAndName;
        if (s1 != null && s2 != null) {
          typeAndName = Container([
            s1,
            typeNameSeparator,
            s2,
          ]);
        } else {
          typeAndName = Container([s1, s2]);
        }

        return Container([
          expr.comment,
          expr.isFinal == true ? finalKeyword : varKeyword,
          typeAndName,
          expr.init != null ? Container([' = ', expr.init]) : null,
        ]);
      }, child);
}

class CodeVar extends CodeConfigProxyNode<CodeVar> {
  final CodeVarName name;
  final CodeType type;
  final bool isFinal;
  final CodeExpr init;
  final CodeComment comment;

  CodeVar._({
    @required this.name,
    this.type,
    this.isFinal,
    this.init,
    this.comment,
  }) : assert(name != null, 'var name is required.');

  factory CodeVar.of({
    @required dynamic name,
    dynamic type,
    dynamic comment,
    bool isFinal,
    dynamic init,
  }) =>
      CodeVar._(
        name: CodeVarName.of(name),
        type: CodeType._parse(type, error: () {
          throw 'invalid type "$type" found';
        }),
        init: CodeExpr.of(init),
        isFinal: isFinal,
        comment: CodeComment.of(comment),
      );
}
