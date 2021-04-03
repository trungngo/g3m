part of g3.techlab;

class CodeConstructorConfig extends CodeConfigNode<CodeConstructor> {
  CodeConstructorConfig(NodeBuildFunc<CodeConstructor> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeConstructorConfig.forTypescriptLike(Node child) =>
      CodeConstructorConfig._internal(
        child,
        appendConstructorName: false,
        appendClassName: false,
        constructorKeyword: 'constructor',
        publicKeyword: '',
      );

  factory CodeConstructorConfig.forDartLike(Node child) =>
      CodeConstructorConfig._internal(
        child,
        appendConstructorName: true,
        appendClassName: true,
        factoryKeyword: 'factory ',
        publicKeyword: '',
        privateKeyword: '',
        protectedKeyword: '',
      );

  factory CodeConstructorConfig.forJavaLike(Node child) =>
      CodeConstructorConfig._internal(
        child,
        appendConstructorName: false,
        appendClassName: true,
      );

  factory CodeConstructorConfig._internal(
    Node child, {
    String constructorKeyword,
    bool appendClassName = true,
    bool appendConstructorName = false,
    String factoryKeyword,
    String privateKeyword = 'private ',
    String publicKeyword = 'public ',
    String protectedKeyword = 'protected ',
  }) =>
      CodeConstructorConfig((context, constructor) {
        final clazz = context.dependOnAncestorNodeOfExactType<CodeClass>();

        Node name;

        if (appendClassName == true &&
            appendConstructorName == true &&
            constructor.name != null) {
          name = Container([clazz.name, '.', constructor.name]);
        } else if (appendClassName) {
          name = clazz.name;
        } else {
          name = constructor.name;
        }

        final keywords = <String>[
          if (constructor.isFactory == true) factoryKeyword,
          if (constructor.isPrivate == true) privateKeyword,
          if (constructor.isProtected == true) protectedKeyword,
          if (constructor.isPublic == true) publicKeyword,
        ];

        final def = Container([
          '\n',
          constructor.comment,
          constructor.annotations,
          Trim.leftRight(
            Container([
              ...keywords,
              constructorKeyword,
              name,
              '(',
              constructor.args,
              ')',
              constructor.init,
            ]),
          ),
        ]);

        if (constructor.body == null) {
          return CodeExpr.open(def);
        } else {
          return CodeExpr.closed(
            Container([
              def,
              ' ',
              constructor.body,
              '\n',
            ]),
          );
        }
      }, child);
}

class CodeConstructor extends CodeConfigProxyNode<CodeConstructor>
    implements _NamedNode {
  /// The constructor name. This is often optional.
  @override
  final CodeConstructorName name;

  /// The comment level for constructor.
  final CodeComment comment;

  /// The list of annotations
  final CodeAnnotationList annotations;

  /// The constructor argument list.
  final CodeArgList args;

  /// The list of initializer expressions
  final CodeStatementList init;

  /// The class implementation body
  final CodeBlock body;

  final bool isFactory;

  final bool isPrivate;

  final bool isPublic;

  final bool isProtected;

  CodeConstructor._({
    this.name,
    this.comment,
    this.annotations,
    this.args,
    this.init,
    this.body,
    this.isFactory,
    this.isPrivate,
    this.isPublic,
    this.isProtected,
  });

  /// Creates a constructor method.
  /// - [name] is a dynamic field that accepts:
  ///   - a [String] name
  ///   - any object that implements [_NamedNode]. This field will have the
  ///     the same name with the other object.
  ///   - any object. In this case, the whole object will be converted
  ///     to string.
  ///
  /// - zero or one of [public], [private], [protected], and [internal] should
  ///   be specified to control the constructor access modifier.
  ///
  /// - [requiredArgs], [optionalArgs], and [namedArgs] are the list of
  /// arguments of the constructor. For language that does not support
  /// optional and named args, those will be rendered just like required arg.
  /// See [CodeArg.of] method to see different format can be sent into the
  /// argument.
  ///
  /// - [init] is the list of initializers for the constructor.
  /// - [body] is the constructor function body.
  ///
  factory CodeConstructor.of({
    dynamic name,
    bool factory,
    bool private,
    bool public,
    bool protected,
    dynamic requiredArgs,
    dynamic optionalArgs,
    dynamic namedArgs,
    dynamic comment,
    dynamic annotations,
    dynamic init,
    dynamic body,
  }) {
    return CodeConstructor._(
      name: CodeConstructorName.of(
        name,
        isPrivate: private,
        isProtected: protected,
      ),
      isFactory: factory,
      isPrivate: private,
      isPublic: public,
      isProtected: protected,
      args: CodeArgList.of(
        required: requiredArgs,
        optional: optionalArgs,
        named: namedArgs,
      ),
      init: CodeStatementList.of(init, closed: true),
      comment: CodeComment.of(comment),
      annotations: CodeAnnotationList.of(annotations),
      body: CodeBlock.of(CodeStatementList.of(body)),
    );
  }
}
