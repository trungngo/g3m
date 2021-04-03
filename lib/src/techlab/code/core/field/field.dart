part of g3.techlab;

class CodeFieldConfig extends CodeConfigNode<CodeField> {
  CodeFieldConfig(NodeBuildFunc<CodeField> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeFieldConfig.forDartLike(Node child) => CodeFieldConfig._internal(
        child,
        typeFirst: true,
        typeNameSeparator: ' ',
        optionalSuffix: null,
        overrideAsAnnotation: true,
        overrideKeyword: null,
        privateKeyword: null,
        publicKeyword: null,
        protectedKeyword: null,
        internalKeyword: null,
        abstractKeyword: 'abstract ',
        staticKeyword: 'static ',
        finalKeyword: 'final ',
        nonFinalKeyword: null,
        optionalKeyword: null,
      );

  factory CodeFieldConfig.forJavaLike(Node child) => CodeFieldConfig._internal(
        child,
        typeFirst: true,
        typeNameSeparator: ' ',
        optionalSuffix: null,
        overrideAsAnnotation: false,
        overrideKeyword: null,
        privateKeyword: 'private ',
        publicKeyword: 'public ',
        protectedKeyword: 'protected ',
        internalKeyword: null,
        abstractKeyword: 'abstract ',
        staticKeyword: 'static ',
        finalKeyword: 'final ',
        nonFinalKeyword: null,
        optionalKeyword: null,
      );

  factory CodeFieldConfig.forKotlinLike(Node child) =>
      CodeFieldConfig._internal(
        child,
        typeFirst: false,
        typeNameSeparator: ': ',
        optionalSuffix: '?',
        overrideAsAnnotation: false,
        overrideKeyword: null,
        privateKeyword: 'private ',
        publicKeyword: '',
        protectedKeyword: 'protected ',
        internalKeyword: null,
        abstractKeyword: 'abstract ',
        staticKeyword: null,
        finalKeyword: 'val ',
        nonFinalKeyword: 'var ',
        optionalKeyword: null,
      );

  factory CodeFieldConfig.forTypescriptLike(Node child) =>
      CodeFieldConfig._internal(
        child,
        typeFirst: false,
        typeNameSeparator: ': ',
        optionalSuffix: '?',
        overrideAsAnnotation: false,
        overrideKeyword: null,
        privateKeyword: 'private ',
        publicKeyword: 'public ',
        protectedKeyword: 'protected ',
        internalKeyword: null,
        abstractKeyword: 'abstract ',
        staticKeyword: 'static ',
        finalKeyword: 'readonly ',
        nonFinalKeyword: null,
        optionalKeyword: null,
      );

  factory CodeFieldConfig._internal(
    Node child, {
    @required bool typeFirst,
    @required String typeNameSeparator,
    @required String optionalSuffix,
    @required bool overrideAsAnnotation,
    @required String overrideKeyword,
    @required String privateKeyword,
    @required String publicKeyword,
    @required String protectedKeyword,
    @required String internalKeyword,
    @required String abstractKeyword,
    @required String staticKeyword,
    @required String finalKeyword,
    @required String nonFinalKeyword,
    @required String optionalKeyword,
  }) =>
      CodeFieldConfig((context, field) {
        final modifiers = <String>[
          if (field.isOverride == true) overrideKeyword,
          if (field.isPrivate == true) privateKeyword,
          if (field.isPublic == true) publicKeyword,
          if (field.isProtected == true) protectedKeyword,
          if (field.isInternal == true) internalKeyword,
          if (field.isAbstract == true) abstractKeyword,
          if (field.isStatic == true) staticKeyword,
          if (field.isFinal == true) finalKeyword else nonFinalKeyword,
          if (field.isOptional == true) optionalKeyword,
        ];

        Node s1 = field.name;
        Node s2 = field.type;

        if (field.isOptional == true && optionalSuffix?.isNotEmpty == true) {
          s1 = Pad.right(optionalSuffix, s1, onlyIfMissing: true);
        }

        if (typeFirst == true) {
          var tmp = s1;
          s1 = s2;
          s2 = tmp;
        }

        return Container([
          '\n',
          CodeExpr.open(
            Container([
              field.comment,
              field.annotations,
              // In the case of dart language, override is an annotation.
              // For csharp, it is an modifier.
              overrideAsAnnotation == true && field.isOverride == true
                  ? '@override\n'
                  : null,
              Container(modifiers),
              s1,
              typeNameSeparator,
              s2,
              field.init != null ? Container([' = ', field.init]) : null,
            ]),
          )
        ]);
      }, child);
}

class CodeField extends CodeConfigProxyNode<CodeField> implements _NamedNode {
  // The field name. This is required.
  @override
  final CodeFieldName name;

  final CodeAnnotationList annotations;

  final bool isOverride;
  final bool isPrivate;
  final bool isPublic;
  final bool isProtected;
  final bool isInternal;
  final bool isAbstract;
  final bool isStatic;
  final bool isFinal;
  final bool isOptional;

  // The field data type. This is required.
  final CodeType type;

  final CodeExpr init;

  final CodeComment comment;

  CodeField._({
    @required this.name,
    this.annotations,
    @required this.type,
    this.init,
    this.comment,
    this.isOverride,
    this.isPrivate,
    this.isPublic,
    this.isProtected,
    this.isInternal,
    this.isAbstract,
    this.isStatic,
    this.isFinal,
    this.isOptional,
  });

  /// Try parse a dynamic value to an argument object.
  static CodeField _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeField>(value, (v) {
      final list = _toDynamicNodeList(v);

      if (list?.isNotEmpty != true || list.length > 3) {
        return null;
      }

      // Try to parse the input as the name expression.
      final name = CodeFieldName._parse(list[0]);
      // Don't accept null
      if (name == null) return null;

      final type =
          list.length > 1 ? CodeType._parse(list[1], error: error) : null;

      final init =
          list.length > 2 ? CodeExpr._parse(list[2], error: error) : null;

      return CodeField._(
        name: name,
        type: type,
        init: init,
      );
    }, error: error);
  }

  factory CodeField.of({
    dynamic name,
    dynamic annotations,
    bool isOverride,
    bool isPrivate,
    bool isPublic,
    bool isProtected,
    bool isInternal,
    bool isAbstract,
    bool isStatic,
    bool isFinal,
    bool isOptional,
    dynamic type,
    dynamic init,
    dynamic comment,
  }) {
    return CodeField._(
      name: CodeFieldName.of(
        name: name,
        // FIXME:
        isOverride: isOverride,
        isPrivate: isPrivate,
        isPublic: isPublic,
        isProtected: isProtected,
        isInternal: isInternal,
        isStatic: isStatic,
        isFinal: isFinal,
      ),
      annotations: CodeAnnotationList._parse(annotations, error: () {
        throw '$annotations is not a valid annotation list';
      }),
      isOverride: isOverride,
      isPrivate: isPrivate,
      isPublic: isPublic,
      isProtected: isProtected,
      isInternal: isInternal,
      isStatic: isStatic,
      isFinal: isFinal,
      isOptional: isOptional,
      type:
          CodeType._parse(type, error: () => '$type is not a valid data type.'),
      init: CodeExpr.of(init),
      comment: CodeComment.of(comment),
    );
  }
}
