part of g3.techlab;

class CodePlaceHolderConfig extends CodeConfigNode<CodePlaceHolder> {
  final String startMarker;
  final String endMarker;

  CodePlaceHolderConfig(this.startMarker, this.endMarker,
      NodeBuildFunc<CodePlaceHolder> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodePlaceHolderConfig.forXml(Node child) =>
      CodePlaceHolderConfig.forJavaLike(child,
          commentFunc: StringFuncs.code.commentXml);

  factory CodePlaceHolderConfig.forJavaLike(
    Node child, {
    String startMarker = 'region custom code of ',
    String endMarker = 'endregion custom code of ',
    StringFunc commentFunc,
    StringFunc nameFunc,
  }) {
    return CodePlaceHolderConfig(startMarker, endMarker, (context, expr) {
      commentFunc ??= StringFuncs.code.commentDoubleSplash;
      nameFunc ??= StringFuncs.noop;

      assert(context.findAncestorNodeOfExactType<CodePlaceHolder>() == null,
          'throw cannot have nested custom code');

      final name = TextTransform(expr.name, nameFunc);

      return Container([
        '\n',
        commentFunc(startMarker),
        name,
        '\n',
        expr.body,
        commentFunc(endMarker),
        name,
        '\n',
      ]);
    }, child);
  }
}

class CodePlaceHolder extends CodeConfigProxyNode<CodePlaceHolder>
    implements _NamedNode {
  @override
  final Node name;

  final Node body;

  CodePlaceHolder._({@required this.name, this.body})
      : assert(name != null, 'name is required');

  factory CodePlaceHolder.of({
    @required dynamic name,
    dynamic comment,
    dynamic body,
  }) {
    if (name == null && body == null) return null;
    return CodePlaceHolder._(
      name: _parseNameNode(name, error: () {
        throw 'invalid custom code name "$name" found';
      }),
      body: Container([
        CodeComment.of(comment),
        CodeStatementList.of(body),
      ]),
    );
  }
}
