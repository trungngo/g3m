part of g3.techlab;

class CodePropertySetterConfig extends CodeConfigNode<CodePropertySetter> {
  CodePropertySetterConfig(
      NodeBuildFunc<CodePropertySetter> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodePropertySetterConfig.forDartLike(Node child) =>
      CodePropertySetterConfig._internal(child, overrideAsAnnotation: true);

  factory CodePropertySetterConfig.forTypescriptLike(Node child) =>
      CodePropertySetterConfig._internal(child, overrideAsAnnotation: true);

  factory CodePropertySetterConfig.forJavaLike(Node child) =>
      CodePropertySetterConfig._internal(child);

  factory CodePropertySetterConfig.forKotlinLike(Node child) =>
      CodePropertySetterConfig._internal(
        child,
        overrideAsAnnotation: true,
        justSetKeyword: true,
        setKeyword: 'set',
        asFunction: true,
      );

  factory CodePropertySetterConfig._internal(
    Node child, {
    String setKeyword = 'set ',
    bool justSetKeyword,
    bool overrideAsAnnotation = false,
    bool typeFirst,
    bool getFirst,
    bool getAsPartOfName,
    bool asFunction,
  }) {
    return CodePropertySetterConfig((context, setter) {
      // Gets out the parent property
      final property = context.dependOnAncestorNodeOfExactType<CodeProperty>();
      final modifier = property.modifier;

      Node setterNode;

      if (justSetKeyword == true) {
        setterNode = Container([
          setKeyword,
          if (asFunction == true) '(value)',
        ]);
      } else {
        final name = property.name;
        final type = property.type;

        setterNode = Container([
          modifier,
          setKeyword,
          name,
          '(',
          CodeArg.of(name: 'value', type: type),
          ')',
        ]);
      }

      final def = Container([
        '\n',
        setter.comment,
        setter.annotations,

        // In the case of dart language, override is an annotation.
        // For csharp, it is an modifier.
        overrideAsAnnotation == true && modifier?.isOverride == true
            ? '@override\n'
            : null,

        setterNode,
      ]);

      if (setter.body == null) {
        return CodeExpr.open(def);
      } else {
        return CodeExpr.closed(
          Container([
            def,
            Text.space(),
            setter.body,
          ]),
        );
      }
    }, child);
  }
}

class CodePropertySetter extends CodeConfigProxyNode<CodePropertySetter> {
  /// The property setter comment.
  final CodeComment comment;

  /// The list of annotations applied to the setter function.
  final CodeAnnotationList annotations;

  /// The setter implementation.
  final CodeBlock body;

  CodePropertySetter._({
    this.comment,
    this.annotations,
    @required this.body,
  }) : assert(body != null, 'property body is required.');

  factory CodePropertySetter._parse(
    dynamic value, {
    NodeParseErrorFunc error,
  }) {
    return parseNode<CodePropertySetter>(value, (v) {
      final statements = CodeStatementList._parse(v);
      return CodePropertySetter._(
        body: CodeBlock.of(statements),
      );
    }, error: error);
  }

  factory CodePropertySetter.of({
    @required dynamic body,
    dynamic annotations,
    dynamic comment,
  }) {
    if (comment == null && annotations == null && body == null) {
      return null;
    }

    return CodePropertySetter._(
      comment: CodeComment.of(comment),
      annotations: CodeAnnotationList.of(annotations),
      body: CodeBlock.of(CodeStatementList.of(body)),
    );
  }
}
