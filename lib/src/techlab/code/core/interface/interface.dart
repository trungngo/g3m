part of g3.techlab;

class CodeInterfaceConfig extends CodeConfigNode<CodeInterface> {
  CodeInterfaceConfig(NodeBuildFunc<CodeInterface> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeInterfaceConfig.forJavaLike(
    Node child, {
    String interfaceKeyword = 'interface ',
    String extendsKeyword = 'extends ',
  }) =>
      CodeInterfaceConfig((context, interface) {
        return Container([
          '\n',
          interface.comment,
          Trim.leftRight(
            Container([
              interface.modifier,
              interfaceKeyword,
              interface.name,
              interface.generic,
              ' ',
              interface.extend != null
                  ? Container([
                      extendsKeyword,
                      interface.extend,
                    ])
                  : null,
            ]),
          ),
          ' ',
          interface.body,
          '\n',
        ]);
      }, child);
}

class CodeInterface extends CodeConfigProxyNode<CodeInterface>
    implements _NamedNode {
  /// The class name.
  @override
  final CodeTypeName name;

  /// Defines public, private, protected, etc.
  final CodeModifier modifier;

  /// The list of generic param applied for the class.
  final CodeGenericParamList generic;

  /// The list of data types that this class extends from.
  final CodeTypeList extend;

  /// Interface-level code comment.
  final CodeComment comment;

  /// The class body.
  final CodeBlock body;

  CodeInterface({
    @required this.name,
    this.modifier,
    this.generic,
    this.extend,
    this.comment,
    this.body,
  }) : assert(name != null);

  factory CodeInterface.of({
    @required dynamic name,
    dynamic comment,
    bool isPrivate,
    bool isPublic,
    bool isProtected,
    bool isInternal,
    bool isAbstract,
    bool isStatic,
    dynamic generic,
    dynamic extend,
    dynamic fields,
    dynamic functions,
    Node body,
  }) =>
      CodeInterface(
        name: CodeTypeName.of(name),
        comment: CodeComment.of(comment),
        modifier: CodeModifier(
          isPrivate: isPrivate,
          isPublic: isPublic,
          isProtected: isProtected,
          isInternal: isInternal,
          isAbstract: isAbstract,
          isStatic: isStatic,
        ),
        generic: CodeGenericParamList.of(generic),
        extend: CodeTypeList.of(extend),
        body: CodeBlock.of(
          Container([
            CodeStatement.of(Container([
              CodeFieldList.of(fields),
              CodeFunctionList.of(functions),
            ])),
            body,
          ]),
        ),
      );
}
