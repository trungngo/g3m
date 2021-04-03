part of g3.techlab;

class CodePropertyGetterConfig extends CodeConfigNode<CodePropertyGetter> {
  CodePropertyGetterConfig(
      NodeBuildFunc<CodePropertyGetter> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodePropertyGetterConfig.forDartLike(Node child) =>
      CodePropertyGetterConfig._internal(
        child,
        overrideAsAnnotation: true,
        typeFirst: true,
        getKeyword: ' get',
        typeNameSeparator: ' ',
      );

  factory CodePropertyGetterConfig.forTypescriptLike(Node child) =>
      CodePropertyGetterConfig._internal(
        child,
        typeFirst: false,
        getFirst: true,
        overrideAsAnnotation: true,
        typeNameSeparator: ': ',
        asFunction: true,
      );

  factory CodePropertyGetterConfig.forJavaLike(Node child) =>
      CodePropertyGetterConfig._internal(
        child,
        overrideAsAnnotation: true,
        typeFirst: true,
        typeNameSeparator: ' ',
        getAsPartOfName: true,
        asFunction: true,
      );

  factory CodePropertyGetterConfig.forKotlinLike(Node child) =>
      CodePropertyGetterConfig._internal(
        child,
        overrideAsAnnotation: true,
        justGetKeyword: true,
        getKeyword: 'get',
        asFunction: true,
      );

  /// [typeFirst] = true if the type need to go in the first part
  /// of the definition.
  /// [getFirst] = true if the get keyword need to go before
  /// the type definition.
  /// [getAsPartOfName] = true if the get keyword need to baked
  /// into the property name (e.g., for java language).
  /// [asFunction] = true if the property name need to be ended with ()
  ///
  factory CodePropertyGetterConfig._internal(
    Node child, {
    String getKeyword = 'get ',
    bool justGetKeyword,
    bool overrideAsAnnotation = false,
    bool typeFirst,
    bool getFirst,
    bool getAsPartOfName,
    bool asFunction,
    String typeNameSeparator,
  }) {
    return CodePropertyGetterConfig((context, getter) {
      // Gets out the parent property
      final property = context.dependOnAncestorNodeOfExactType<CodeProperty>();
      final modifier = property.modifier;

      Node getterNode;

      if (justGetKeyword == true) {
        getterNode = Container([
          getKeyword,
          if (asFunction == true) '()',
        ]);
      } else {
        Node s1 = property.name;
        Node s2 = property.type;

        if (getAsPartOfName == true) {
          s1 = CodePropertyName.of(Container([getKeyword, property.name.name]));
          getKeyword = null;
        }

        if (asFunction == true) {
          s1 = Container([s1, '()']);
        }

        if (typeFirst == true) {
          var tmp = s1;
          s1 = s2;
          s2 = tmp;
        }

        getterNode = Container([
          modifier,
          if (getFirst == true) getKeyword,
          s1,
          if (getFirst != true) getKeyword,
          typeNameSeparator,
          s2,
        ]);
      }

      final def = Container([
        '\n',
        getter.comment,
        getter.annotations,

        // In the case of dart language, override is an annotation.
        // For csharp, it is an modifier.
        overrideAsAnnotation == true && modifier?.isOverride == true
            ? '@override\n'
            : null,

        getterNode,
      ]);

      if (getter.body == null) {
        return CodeExpr.open(def);
      } else {
        return CodeExpr.closed(
          Container([
            def,
            Text.space(),
            getter.body,
          ]),
        );
      }
    }, child);
  }
}

class CodePropertyGetter extends CodeConfigProxyNode<CodePropertyGetter> {
  /// The comment for this getter.
  final CodeComment comment;

  /// The list of annotations applied to this getter.
  final CodeAnnotationList annotations;

  /// The getter implementation.
  final CodeBlock body;

  CodePropertyGetter._({
    this.comment,
    this.annotations,
    @required this.body,
  });

  factory CodePropertyGetter._parse(
    dynamic value, {
    NodeParseErrorFunc error,
  }) {
    return parseNode<CodePropertyGetter>(value, (v) {
      final statements = CodeStatementList._parse(v);
      return CodePropertyGetter._(
        body: CodeBlock.of(statements),
      );
    }, error: error);
  }

  factory CodePropertyGetter.of({
    @required dynamic body,
    dynamic annotations,
    dynamic comment,
  }) =>
      CodePropertyGetter._(
        comment: CodeComment.of(comment),
        annotations: CodeAnnotationList.of(annotations),
        body: CodeBlock.of(CodeStatementList.of(body)),
      );
}
