part of g3.techlab;

class CodeArgConfig extends CodeConfigNode<CodeArg> {
  CodeArgConfig(NodeBuildFunc<CodeArg> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeArgConfig.forDartLike(Node child) {
    return CodeArgConfig._internal(
      child,
      typeFirst: true,
      acceptThisSyntax: true,
      finalPrefix: 'final ',
    );
  }

  factory CodeArgConfig.forTypescriptLike(Node child) {
    return CodeArgConfig._internal(
      child,
      typeFirst: false,
      separator: ': ',
      finalPrefix: 'readonly ',
      privatePrefix: 'private ',
      acceptThisSyntax: true,
      optionalSuffix: '?',
    );
  }

  factory CodeArgConfig.forKotlin(Node child) {
    return CodeArgConfig._internal(
      child,
      typeFirst: false,
      separator: ': ',
      finalPrefix: 'val ',
      privatePrefix: 'private ',
      acceptThisSyntax: true,
      optionalSuffix: '?',
    );
  }

  factory CodeArgConfig.forJavaLike(Node child) {
    return CodeArgConfig._internal(
      child,
      typeFirst: true,
      finalPrefix: 'final ',
    );
  }

  factory CodeArgConfig._internal(
    Node child, {
    @required bool typeFirst,
    String separator = ' ',
    String finalPrefix,
    String nonFinalPrefix,
    String privatePrefix,
    bool acceptThisSyntax = false,
    String optionalSuffix,
  }) {
    return CodeArgConfig((context, arg) {
      final container = context.ancestors.firstWhere(
          (e) => e is CodeConstructor || e is CodeFunction,
          orElse: () => null);

      Node type = arg.type;
      Node name = arg.name;

      if (arg.isOptional == true && optionalSuffix?.isNotEmpty == true) {
        name = Pad.right(optionalSuffix, name, onlyIfMissing: true);
      }

      Node typeAndName;

      if (type != null && name != null) {
        typeAndName = typeFirst == true
            ? Container([type, separator, name])
            : Container([name, separator, type]);
      } else if (name != null) {
        if (container is CodeConstructor && acceptThisSyntax == true) {
          // Appends ".this" prefix to the constructor argument.
          typeAndName = Pad.left('this.', name);
        } else {
          typeAndName = name;
        }
      } else {
        typeAndName = type;
      }

      Node privateModifier;
      if (arg.isPrivate == true && privatePrefix != null) {
        privateModifier = Text(privatePrefix);
      }

      Node modifier;
      if (arg.isFinal == true) {
        if (finalPrefix != null) modifier = Text(finalPrefix);
      } else {
        if (nonFinalPrefix != null) modifier = Text(nonFinalPrefix);
      }

      Node init = arg.init;
      if (init != null) {
        init = Container([' = ', arg.init]);
      }

      return Container([
        arg.annotations,
        privateModifier,
        modifier,
        typeAndName,
        init,
      ]);
    }, child);
  }
}

class CodeArg extends CodeConfigProxyNode<CodeArg> implements _NamedNode {
  /// The argument name.
  @override
  final CodeArgName name;

  /// The argument data type. This is required in most case, however, for
  /// constructor argument, if this is missing, the argument can be
  /// like `this.name`, just like how dart language work.
  final CodeType type;

  /// The argument initializer
  final CodeExpr init;

  /// True indicates this field name is private.
  final bool isPrivate;

  final bool isFinal;

  final bool isOptional;

  final CodeAnnotationList annotations;

  CodeArg._({
    @required this.name,
    @required this.type,
    @required this.init,
    @required this.isPrivate,
    @required this.isFinal,
    @required this.isOptional,
    @required this.annotations,
  });

  /// Try parse a dynamic value to an argument object.
  static CodeArg _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeArg>(value, (v) {
      final list = _toDynamicNodeList(v);

      if (list?.isNotEmpty != true || list.length > 3) {
        return null;
      }

      // Try to parse the input as the name expression.
      final name = CodeArgName._parse(list[0]);
      // Don't accept null
      if (name == null) return null;

      final type =
          list.length > 1 ? CodeType._parse(list[1], error: error) : null;

      final init =
          list.length > 2 ? CodeExpr._parse(list[2], error: error) : null;

      return CodeArg._(
        name: name,
        type: type,
        init: init,
        isPrivate: false,
        isFinal: false,
        isOptional: null,
        annotations: null,
      );
    }, error: error);
  }

  factory CodeArg.of({
    @required dynamic name,
    @required dynamic type,
    bool isPrivate,
    bool isFinal,
    bool isOptional,
    dynamic init,
    dynamic annotations,
  }) {
    return CodeArg._(
      name: CodeArgName.of(
        name: name,
        isPrivate: isPrivate,
      ),
      type:
          CodeType._parse(type, error: () => '$type is not a valid data type.'),
      init: CodeExpr.of(init),
      isPrivate: isPrivate,
      isFinal: isFinal,
      isOptional: isOptional,
      annotations: CodeAnnotationList._parse(annotations, error: () {
        throw '$annotations is not a valid annotation list';
      }),
    );
  }

  factory CodeArg.ofField({
    @required CodeField field,
  }) =>
      CodeArg.of(
        name: field.name,
        type: null,
        isPrivate: field.isPrivate,
      );
}
