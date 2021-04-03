part of g3.techlab;

class CodeCommentConfig extends CodeConfigNode<CodeComment> {
  CodeCommentConfig(NodeBuildFunc<CodeComment> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeCommentConfig.byStringFunc(StringFunc func, Node child) =>
      CodeCommentConfig((context, codeComment) {
        return Container([TextTransform(codeComment.text, func), NewLine()]);
      }, child);

  factory CodeCommentConfig.doubleSplash(Node child) =>
      CodeCommentConfig.byStringFunc(
          StringFuncs.code.commentDoubleSplash, child);

  factory CodeCommentConfig.tripleSplash(Node child) =>
      CodeCommentConfig.byStringFunc(
          StringFuncs.code.commentTripleSplash, child);

  factory CodeCommentConfig.javaDoc(Node child) =>
      CodeCommentConfig.byStringFunc(StringFuncs.code.commentJavaDoc, child);

  factory CodeCommentConfig.hash(Node child) =>
      CodeCommentConfig.byStringFunc(StringFuncs.code.commentHash, child);

  factory CodeCommentConfig.forDartLike(Node child) =>
      CodeCommentConfig.forCode(
        child,
        enumFunc: StringFuncs.code.commentTripleSplash,
        classFunc: StringFuncs.code.commentTripleSplash,
        mixinFunc: StringFuncs.code.commentTripleSplash,
        interfaceFunc: StringFuncs.code.commentTripleSplash,
        fieldFunc: StringFuncs.code.commentTripleSplash,
        propertyFunc: StringFuncs.code.commentTripleSplash,
        constructorFunc: StringFuncs.code.commentTripleSplash,
        functionFunc: StringFuncs.code.commentTripleSplash,
        otherFunc: StringFuncs.code.commentDoubleSplash,
      );

  factory CodeCommentConfig.forJavaLike(Node child) =>
      CodeCommentConfig.forCode(
        child,
        enumFunc: StringFuncs.code.commentJavaDoc,
        classFunc: StringFuncs.code.commentJavaDoc,
        mixinFunc: null,
        interfaceFunc: StringFuncs.code.commentJavaDoc,
        fieldFunc: StringFuncs.code.commentJavaDoc,
        propertyFunc: StringFuncs.code.commentJavaDoc,
        constructorFunc: StringFuncs.code.commentJavaDoc,
        functionFunc: StringFuncs.code.commentJavaDoc,
        otherFunc: StringFuncs.code.commentDoubleSplash,
      );

  factory CodeCommentConfig.forXml(Node child) => CodeCommentConfig.forCode(
        child,
        enumFunc: null,
        classFunc: null,
        mixinFunc: null,
        interfaceFunc: null,
        fieldFunc: null,
        propertyFunc: null,
        constructorFunc: null,
        functionFunc: null,
        otherFunc: StringFuncs.code.commentXml,
      );

  factory CodeCommentConfig.forCode(
    Node child, {
    @required StringFunc enumFunc,
    @required StringFunc classFunc,
    @required StringFunc mixinFunc,
    @required StringFunc interfaceFunc,
    @required StringFunc fieldFunc,
    @required StringFunc propertyFunc,
    @required StringFunc constructorFunc,
    @required StringFunc functionFunc,
    @required StringFunc otherFunc,
  }) =>
      CodeCommentConfig((context, codeComment) {
        // Finds the nearest container for this comment.
        final container = context.ancestors.firstWhere(
            (e) =>
                e is CodeBlock ||
                e is CodeEnum ||
                e is CodeEnumValue ||
                e is CodeMixin ||
                e is CodeClass ||
                e is CodeInterface ||
                e is CodeField ||
                e is CodeProperty ||
                e is CodePropertyGetter ||
                e is CodePropertySetter ||
                e is CodeConstructor ||
                e is CodeFunction,
            orElse: () => null);

        var func;
        if (container != null) {
          // Determines the comment style for the given container.
          if (container is CodeEnum || container is CodeEnumValue) {
            func = enumFunc;
          } else if (container is CodeMixin) {
            func = mixinFunc;
          } else if (container is CodeClass) {
            func = classFunc;
          } else if (container is CodeInterface) {
            func = interfaceFunc;
          } else if (container is CodeField) {
            func = fieldFunc;
          } else if (container is CodeProperty ||
              container is CodePropertySetter ||
              container is CodePropertyGetter) {
            func = propertyFunc;
          } else if (container is CodeConstructor) {
            func = constructorFunc;
          } else if (container is CodeFunction) {
            func = functionFunc;
          }
        }

        func ??= otherFunc;

        return Container([TextTransform(codeComment.text, func), NewLine()]);
      }, child);
}

class CodeComment extends CodeConfigProxyNode<CodeComment> {
  final Node text;

  CodeComment(this.text);

  static CodeComment _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeComment>(value, (v) {
      if (v is Node) {
        return CodeComment(v);
      } else {
        return CodeComment(Text(v?.toString()));
      }
    });
  }

  factory CodeComment.of(dynamic value) {
    return CodeComment._parse(value, error: () {
      throw '$value is not a valid comment';
    });
  }
}
