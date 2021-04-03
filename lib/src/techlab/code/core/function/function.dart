part of g3.techlab;

class CodeFunctionConfig extends CodeConfigNode<CodeFunction> {
  CodeFunctionConfig(NodeBuildFunc<CodeFunction> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeFunctionConfig.forTypescriptLike(Node child) =>
      CodeFunctionConfig._internal(
        child,
        returnsAfter: true,
        returnSeparator: ': ',
      );

  factory CodeFunctionConfig.forKotlinLike(Node child) =>
      CodeFunctionConfig._internal(
        child,
        voidKeyword: null,
        returnsAfter: true,
        returnSeparator: ': ',
        functionKeywords: 'fun ',
        throwsAsAnnotation: true,
      );

  factory CodeFunctionConfig.forDartLike(Node child) =>
      CodeFunctionConfig._internal(child);

  factory CodeFunctionConfig.forJavaLike(Node child) =>
      CodeFunctionConfig._internal(
        child,
        overrideKeyword: '@Override',
      );

  /// [returnsAfter] determines if the return clause should be put
  /// in front or at the end of the function definition.
  ///
  factory CodeFunctionConfig._internal(
    Node child, {
    String throwKeyword = 'throws',
    String voidKeyword = 'void',
    String overrideKeyword = '@override',
    String functionKeywords = '',
    bool overrideAsAnnotation = true,
    bool throwsAsAnnotation = false,
    bool returnsAfter = false,
    String returnSeparator = '',
  }) =>
      CodeFunctionConfig((context, func) {
        final returns = func.returns ?? voidKeyword;
        final returnNode = returns != null
            ? Container([
                if (returnsAfter && returnSeparator?.isNotEmpty == true)
                  returnSeparator,
                returns,
                if (!returnsAfter) Text.space(),
              ])
            : null;

        Node throwsNode = func.throws;

        if (func.throws?.types?.isNotEmpty == true &&
            throwsAsAnnotation == true) {
          // For kotlin
          // Example: '@Throws(InvalidArgumentException::class)\n'
          throwsNode = Container([
            CodeAnnotation.constructorCall(
              className: throwKeyword,
              args: func.throws.types.map((t) {
                return Pad.right('::class', t.type.name);
              }),
            ),
            '\n',
          ]);
        }

        final def = Container([
          '\n',
          func.comment,
          func.annotations,

          // For kotlin, throws are defined as annotation
          if (throwsAsAnnotation == true)
            throwsNode,

          // In the case of dart language, override is an annotation.
          // For csharp, it is an modifier.
          overrideAsAnnotation == true && func.modifier?.isOverride == true
              ? '${overrideKeyword}\n'
              : null,
          func.modifier,
          if (returnsAfter == false)
            returnNode,
          functionKeywords,
          func.name,
          func.generic,
          '(',
          func.args,
          ')',
          if (returnsAfter == true)
            returnNode,

          if (throwsAsAnnotation != true)
            throwsNode,
        ]);

        if (func.body == null) {
          return CodeExpr.open(def);
        } else {
          return CodeExpr.closed(
            Container([
              def,
              Text.space(),
              func.body,
            ]),
          );
        }
      }, child);
}

class CodeFunction extends CodeConfigProxyNode<CodeFunction>
    implements _NamedNode {
  @override
  final CodeFunctionName name;

  /// The comment at the function level.
  final CodeComment comment;

  /// The list of annotations
  final CodeAnnotationList annotations;

  final CodeModifier modifier;
  final CodeGenericParamList generic;
  final CodeArgList args;
  final CodeFunctionReturnList returns;
  final CodeFunctionThrowList throws;
  final CodeBlock body;

  CodeFunction({
    @required this.name,
    this.comment,
    this.annotations,
    this.modifier,
    this.generic,
    this.args,
    this.returns,
    this.throws,
    this.body,
  });

  factory CodeFunction.of({
    @required dynamic name,
    dynamic comment,
    dynamic annotations,
    bool isOverride,
    bool isPrivate,
    bool isPublic,
    bool isProtected,
    bool isInternal,
    bool isAbstract,
    bool isStatic,
    bool isAsync,
    dynamic generic,
    dynamic requiredArgs,
    dynamic optionalArgs,
    dynamic namedArgs,
    dynamic returns,
    dynamic throws,
    dynamic body,
  }) {
    return CodeFunction(
      name: CodeFunctionName.of(
        name: name,
        isOverride: isOverride,
        isPrivate: isPrivate,
        isPublic: isPublic,
        isProtected: isProtected,
        isInternal: isInternal,
        isStatic: isStatic,
      ),
      comment: CodeComment.of(comment),
      annotations: CodeAnnotationList.of(annotations),
      modifier: CodeModifier(
        isOverride: isOverride,
        isPrivate: isPrivate,
        isPublic: isPublic,
        isProtected: isProtected,
        isInternal: isInternal,
        isStatic: isStatic,
        isAsync: isAsync,
      ),
      generic: CodeGenericParamList.of(generic),
      args: CodeArgList.of(
        required: requiredArgs,
        optional: optionalArgs,
        named: namedArgs,
      ),
      returns: CodeFunctionReturnList.of(returns),
      throws: CodeFunctionThrowList.of(throws),
      body: CodeBlock.of(CodeStatementList.of(body)),
    );
  }
}
