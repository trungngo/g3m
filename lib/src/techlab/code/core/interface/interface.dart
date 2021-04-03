part of g3.techlab;

class CodeInterfaceConfig extends CodeConfigNode<CodeInterface> {
  CodeInterfaceConfig(NodeBuildFunc<CodeInterface> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeInterfaceConfig.forDartLike(Node child) =>
      CodeInterfaceConfig.forJavaLike(
        child,
        interfaceKeyword: 'class ',
        privateKeyword: '',
        protectedKeyword: '',
        publicKeyword: '',
      );

  factory CodeInterfaceConfig.forTypescriptLike(Node child) =>
      CodeInterfaceConfig.forJavaLike(
        child,
        publicKeyword: 'export ',
      );

  factory CodeInterfaceConfig.forJavaLike(
    Node child, {
    String interfaceKeyword = 'interface ',
    String extendsKeyword = 'extends ',
    String privateKeyword = 'private ',
    String protectedKeyword = 'protected ',
    String publicKeyword = 'public ',
    String abstractKeyword = 'abstract ',
    String staticKeyword = 'static ',
  }) =>
      CodeInterfaceConfig((context, interface) {
        final modifiers = <String>[
          if (interface.isStatic == true) staticKeyword,
          if (interface.isPrivate == true) privateKeyword,
          if (interface.isProtected == true) protectedKeyword,
          if (interface.isPublic == true) publicKeyword,
          if (interface.isAbstract == true) abstractKeyword,
        ];

        return Container([
          '\n',
          interface.comment,
          interface.annotations,
          Trim.leftRight(
            Container([
              ...modifiers,
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

  /// The list of generic param applied for the class.
  final CodeGenericParamList generic;

  /// The list of data types that this class extends from.
  final CodeTypeList extend;

  /// Interface-level code comment.
  final CodeComment comment;

  final CodeAnnotationList annotations;

  /// The class body.
  final CodeBlock body;

  final bool isPrivate;

  final bool isProtected;

  final bool isPublic;

  final bool isAbstract;

  final bool isStatic;

  CodeInterface._({
    @required this.name,
    this.generic,
    this.extend,
    this.comment,
    this.annotations,
    this.body,
    this.isPrivate,
    this.isProtected,
    this.isPublic,
    this.isAbstract,
    this.isStatic,
  }) : assert(name != null);

  factory CodeInterface.of({
    @required dynamic name,
    dynamic comment,
    dynamic annotations,
    dynamic generic,
    dynamic extend,
    dynamic fields,
    dynamic functions,
    bool isPrivate,
    bool isProtected,
    bool isPublic,
    bool isAbstract,
    bool isStatic,
    dynamic body,
  }) =>
      CodeInterface._(
        name: CodeTypeName.of(
          name,
          isPrivate: isPrivate,
        ),
        comment: CodeComment.of(comment),
        isPrivate: isPrivate,
        isProtected: isProtected,
        isPublic: isPublic,
        isAbstract: isAbstract,
        isStatic: isStatic,
        generic: CodeGenericParamList.of(generic),
        extend: CodeTypeList.of(extend),
        annotations: CodeAnnotationList.of(annotations),
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
