part of g3.techlab;

typedef CodeConfigBuildFunc<T extends Node> = T Function(
    BuildContext context, Node node);

/// Defines global configuration for dart code generation.
///
/// Java default syntax:
/// - Indentation: 2 spaces
/// - Comment: Triple splash
/// - Block: Curly bracket start at the same line.
///
abstract class OopCodeConfig<T extends ExactlyOneNode<T>>
    extends ExactlyOneNode<T> {
  CodeConfigBuildFunc<IndentConfig> indentConfig;
  CodeConfigBuildFunc<CodeBlockConfig> blockConfig;
  CodeConfigBuildFunc<CodeModifierConfig> codeAccessConfig;
  CodeConfigBuildFunc<CodeCommentConfig> commentConfig;
  CodeConfigBuildFunc<CodePlaceHolderConfig> placeHolderConfig;

  // Package configs
  CodeConfigBuildFunc<CodePackageNameConfig> packageNameConfig;
  CodeConfigBuildFunc<CodePackageConfig> packageConfig;

  // Import Configs
  CodeConfigBuildFunc<CodeImportConfig> importConfig;
  CodeConfigBuildFunc<CodeImportListConfig> importListConfig;
  CodeConfigBuildFunc<CodeImportTypeConfig> importTypeConfig;

  // Type configs
  CodeConfigBuildFunc<CodeTypeNameMapperConfig> typeNameMapperConfig;
  CodeConfigBuildFunc<CodeTypeNameConfig> typeNameConfig;
  CodeConfigBuildFunc<CodeTypeConfig> typeConfig;
  CodeConfigBuildFunc<CodeTypeListConfig> typeListConfig;

  // Expr configs
  CodeConfigBuildFunc<CodeNullLiteralConfig> nullLiteralConfig;
  CodeConfigBuildFunc<CodeBoolLiteralConfig> boolLiteralConfig;
  CodeConfigBuildFunc<CodeCharLiteralConfig> charLiteralConfig;
  CodeConfigBuildFunc<CodeStringLiteralConfig> stringLiteralConfig;
  CodeConfigBuildFunc<CodeNumericLiteralConfig> numericLiteralConfig;
  CodeConfigBuildFunc<CodeArrayLiteralConfig> arrayLiteralConfig;
  CodeConfigBuildFunc<CodeSetLiteralConfig> setLiteralConfig;
  CodeConfigBuildFunc<CodeMapLiteralConfig> mapLiteralConfig;
  CodeConfigBuildFunc<CodeCascadeConfig> cascadeConfig;
  CodeConfigBuildFunc<CodeSpreadConfig> spreadConfig;
  CodeConfigBuildFunc<CodeRefConfig> refConfig;
  CodeConfigBuildFunc<CodeVarConfig> varConfig;

  // Statement configs
  CodeConfigBuildFunc<CodeExprConfig> exprConfig;
  CodeConfigBuildFunc<CodeExprListConfig> exprListConfig;
  CodeConfigBuildFunc<CodeStatementListConfig> statementListConfig;
  CodeConfigBuildFunc<CodeStatementConfig> statementConfig;
  CodeConfigBuildFunc<CodeVarNameConfig> varNameConfig;

  CodeConfigBuildFunc<CodeIfConfig> ifConfig;
  CodeConfigBuildFunc<CodeElseIfConfig> elseIfConfig;
  CodeConfigBuildFunc<CodeReturnConfig> returnConfig;
  CodeConfigBuildFunc<CodeForConfig> forConfig;
  CodeConfigBuildFunc<CodeForEachConfig> forEachConfig;
  CodeConfigBuildFunc<CodeWhileConfig> whileConfig;
  CodeConfigBuildFunc<CodeFunctionCallConfig> functionCallConfig;
  CodeConfigBuildFunc<CodeConstructorCallConfig> constructorCallConfig;
  CodeConfigBuildFunc<CodeAnnotationListConfig> annotationListConfig;

  // Generic configs
  CodeConfigBuildFunc<CodeGenericParamConfig> genericParamConfig;
  CodeConfigBuildFunc<CodeGenericParamListConfig> genericParamListConfig;

  // Field configs
  CodeConfigBuildFunc<CodeFieldNameConfig> fieldNameConfig;
  CodeConfigBuildFunc<CodeFieldListConfig> fieldListConfig;
  CodeConfigBuildFunc<CodeFieldConfig> fieldConfig;

  // Arg configs
  CodeConfigBuildFunc<CodeArgNameConfig> argNameConfig;
  CodeConfigBuildFunc<CodeArgListConfig> argListConfig;
  CodeConfigBuildFunc<CodeArgConfig> argConfig;

  // Function configs
  CodeConfigBuildFunc<CodeFunctionThrowListConfig> functionThrowListConfig;
  CodeConfigBuildFunc<CodeFunctionThrowConfig> functionThrowConfig;
  CodeConfigBuildFunc<CodeFunctionReturnConfig> functionReturnConfig;
  CodeConfigBuildFunc<CodeFunctionReturnListConfig> functionReturnListConfig;
  CodeConfigBuildFunc<CodeFunctionNameConfig> functionNameConfig;
  CodeConfigBuildFunc<CodeFunctionListConfig> functionListConfig;
  CodeConfigBuildFunc<CodeFunctionConfig> functionConfig;
  CodeConfigBuildFunc<CodeLambdaConfig> lambdaConfig;

  // Enum configs
  CodeConfigBuildFunc<CodeEnumValueNameConfig> enumValueNameConfig;
  CodeConfigBuildFunc<CodeEnumValueListConfig> enumValueListConfig;
  CodeConfigBuildFunc<CodeEnumValueConfig> enumValueConfig;
  CodeConfigBuildFunc<CodeEnumNameConfig> enumNameConfig;
  CodeConfigBuildFunc<CodeEnumListConfig> enumListConfig;
  CodeConfigBuildFunc<CodeEnumConfig> enumConfig;

  // Property configs
  CodeConfigBuildFunc<CodePropertyNameConfig> propertyNameConfig;
  CodeConfigBuildFunc<CodePropertyListConfig> propertyListConfig;
  CodeConfigBuildFunc<CodePropertyGetterConfig> propertyGetterConfig;
  CodeConfigBuildFunc<CodePropertySetterConfig> propertySetterConfig;
  CodeConfigBuildFunc<CodePropertyConfig> propertyConfig;

  // Interface configs
  CodeConfigBuildFunc<CodeInterfaceListConfig> interfaceListConfig;
  CodeConfigBuildFunc<CodeInterfaceConfig> interfaceConfig;

  // Class configs
  CodeConfigBuildFunc<CodeClassNameConfig> classNameConfig;
  CodeConfigBuildFunc<CodeClassListConfig> classListConfig;
  CodeConfigBuildFunc<CodeClassConfig> classConfig;
  CodeConfigBuildFunc<CodeConstructorNameConfig> classConstructorNameConfig;
  CodeConfigBuildFunc<CodeConstructorListConfig> classConstructorListConfig;
  CodeConfigBuildFunc<CodeConstructorConfig> classConstructorConfig;

  // Mixin configs
  CodeConfigBuildFunc<CodeMixinNameConfig> mixinNameConfig;
  CodeConfigBuildFunc<CodeMixinListConfig> mixinListConfig;
  CodeConfigBuildFunc<CodeMixinConfig> mixinConfig;

  // Extension configs
  CodeConfigBuildFunc<CodeExtensionNameConfig> extensionNameConfig;
  CodeConfigBuildFunc<CodeExtensionListConfig> extensionListConfig;
  CodeConfigBuildFunc<CodeExtensionConfig> extensionConfig;

  OopCodeConfig(
    Node child, {
    @required this.indentConfig,
    @required this.blockConfig,
    @required this.codeAccessConfig,
    @required this.commentConfig,
    @required this.placeHolderConfig,

    // Package configs
    @required this.packageNameConfig,
    @required this.packageConfig,

    // Import Configs
    @required this.importConfig,
    @required this.importListConfig,
    @required this.importTypeConfig,

    // Type configs
    @required this.typeNameMapperConfig,
    @required this.typeNameConfig,
    @required this.typeConfig,
    @required this.typeListConfig,

    // Expr configs
    @required this.nullLiteralConfig,
    @required this.boolLiteralConfig,
    @required this.charLiteralConfig,
    @required this.stringLiteralConfig,
    @required this.numericLiteralConfig,
    @required this.arrayLiteralConfig,
    @required this.setLiteralConfig,
    @required this.mapLiteralConfig,
    @required this.cascadeConfig,
    @required this.spreadConfig,
    @required this.refConfig,
    @required this.varConfig,

    // Statement configs
    @required this.exprConfig,
    @required this.exprListConfig,
    @required this.statementListConfig,
    @required this.statementConfig,
    @required this.varNameConfig,
    @required this.ifConfig,
    @required this.elseIfConfig,
    @required this.returnConfig,
    @required this.forConfig,
    @required this.forEachConfig,
    @required this.whileConfig,
    @required this.functionCallConfig,
    @required this.constructorCallConfig,
    @required this.annotationListConfig,

    // Generic configs
    @required this.genericParamConfig,
    @required this.genericParamListConfig,

    // Field configs
    @required this.fieldNameConfig,
    @required this.fieldListConfig,
    @required this.fieldConfig,

    // Arg configs
    @required this.argNameConfig,
    @required this.argListConfig,
    @required this.argConfig,

    // Function configs
    @required this.functionThrowListConfig,
    @required this.functionThrowConfig,
    @required this.functionReturnConfig,
    @required this.functionReturnListConfig,
    @required this.functionNameConfig,
    @required this.functionListConfig,
    @required this.functionConfig,
    @required this.lambdaConfig,
    @required this.enumValueNameConfig,
    @required this.enumValueListConfig,
    @required this.enumValueConfig,
    @required this.enumNameConfig,
    @required this.enumListConfig,
    @required this.enumConfig,

    // Property configs
    @required this.propertyNameConfig,
    @required this.propertyListConfig,
    @required this.propertyGetterConfig,
    @required this.propertySetterConfig,
    @required this.propertyConfig,

    // Enum configs

    // Interface configs
    @required this.interfaceListConfig,
    @required this.interfaceConfig,

    // Class configs
    @required this.classNameConfig,
    @required this.classListConfig,
    @required this.classConfig,
    @required this.classConstructorNameConfig,
    @required this.classConstructorListConfig,
    @required this.classConstructorConfig,

    // Mixin configs
    @required this.mixinNameConfig,
    @required this.mixinListConfig,
    @required this.mixinConfig,

    // Extension configs
    @required this.extensionNameConfig,
    @required this.extensionListConfig,
    @required this.extensionConfig,
  }) : super(child) {
    indentConfig ??= (_, child) => IndentConfig.useSpace2(child);
    blockConfig ??= (_, child) => CodeBlockConfig.curlyBracketSameLine(child);
    codeAccessConfig ??= (_, child) => CodeModifierConfig.forJavaLike(child);

    commentConfig ??= (_, child) => CodeCommentConfig.forJavaLike(child);
    placeHolderConfig ??=
        (_, child) => CodePlaceHolderConfig.forJavaLike(child);

    // Package configs
    packageNameConfig ??=
        (_, child) => CodePackageNameConfig.forJavaLike(child);
    packageConfig ??= (_, child) => CodePackageConfig.forJavaLike(child);

    // Import Configs
    importConfig ??= (_, child) => CodeImportConfig.forJavaLike(child);
    importListConfig ??= (_, child) => CodeImportListConfig.forJavaLike(child);
    importTypeConfig ??= (_, child) => CodeImportTypeConfig.forJavaLike(child);

    // Type configs
    typeNameConfig ??= (_, child) => CodeTypeNameConfig.forJavaLike(child);
    typeConfig ??= (_, child) => CodeTypeConfig.forJavaLike(child);
    typeListConfig ??= (_, child) => CodeTypeListConfig.forJavaLike(child);

    // Expr configs
    nullLiteralConfig ??=
        (_, child) => CodeNullLiteralConfig.forJavaLike(child);
    boolLiteralConfig ??=
        (_, child) => CodeBoolLiteralConfig.forJavaLike(child);
    charLiteralConfig ??=
        (_, child) => CodeCharLiteralConfig.forJavaLike(child);
    stringLiteralConfig ??=
        (_, child) => CodeStringLiteralConfig.forJavaLike(child);
    numericLiteralConfig ??=
        (_, child) => CodeNumericLiteralConfig.forJavaLike(child);
    arrayLiteralConfig ??=
        (_, child) => CodeArrayLiteralConfig.forJavaLike(child);
    setLiteralConfig ??= (_, child) => CodeSetLiteralConfig.forJavaLike(child);
    mapLiteralConfig ??= (_, child) => CodeMapLiteralConfig.forJavaLike(child);
    cascadeConfig ??= (_, child) => CodeCascadeConfig.noSupport(child);
    spreadConfig ??= (_, child) => CodeSpreadConfig.noSupport(child);

    // Important: Yield is not supported by default.
    refConfig ??= (_, child) => CodeRefConfig.forJavaLike(child);
    varConfig ??= (_, child) => CodeVarConfig.forJava(child);

    // Statement configs
    exprConfig ??= (_, child) => CodeExprConfig.forJavaLike(child);
    exprListConfig ??= (_, child) => CodeExprListConfig.forJavaLike(child);
    statementListConfig ??=
        (_, child) => CodeStatementListConfig.forJavaLike(child);
    statementConfig ??= (_, child) => CodeStatementConfig.forJavaLike(child);
    varNameConfig ??= (_, child) => CodeVarNameConfig.forJavaLike(child);
    ifConfig ??= (_, child) => CodeIfConfig.forJavaLike(child);
    elseIfConfig ??= (_, child) => CodeElseIfConfig.forJavaLike(child);
    returnConfig ??= (_, child) => CodeReturnConfig.forJavaLike(child);
    forConfig ??= (_, child) => CodeForConfig.forJavaLike(child);
    forEachConfig ??= (_, child) => CodeForEachConfig.forJavaLike(child);
    whileConfig ??= (_, child) => CodeWhileConfig.forJavaLike(child);
    functionCallConfig ??=
        (_, child) => CodeFunctionCallConfig.forJavaLike(child);
    constructorCallConfig ??=
        (_, child) => CodeConstructorCallConfig.forJavaLike(child);

    annotationListConfig ??=
        (_, child) => CodeAnnotationListConfig.forJavaLike(child);

    // Generic configs
    genericParamConfig ??=
        (_, child) => CodeGenericParamConfig.forJavaLike(child);
    genericParamListConfig ??=
        (_, child) => CodeGenericParamListConfig.forJavaLike(child);

    // Field configs
    fieldNameConfig ??= (_, child) => CodeFieldNameConfig.forJavaLike(child);
    fieldListConfig ??= (_, child) => CodeFieldListConfig.forJavaLike(child);
    fieldConfig ??= (_, child) => CodeFieldConfig.forJavaLike(child);

    // Arg configs
    argNameConfig ??= (_, child) => CodeArgNameConfig.forJavaLike(child);
    argListConfig ??= (_, child) => CodeArgListConfig.forJavaLike(child);
    argConfig ??= (_, child) => CodeArgConfig.forJavaLike(child);

    // Function configs
    functionThrowListConfig ??=
        (_, child) => CodeFunctionThrowListConfig.forJavaLike(child);
    functionThrowConfig ??=
        (_, child) => CodeFunctionThrowConfig.forJavaLike(child);
    functionReturnConfig ??=
        (_, child) => CodeFunctionReturnConfig.forJavaLike(child);
    functionReturnListConfig ??=
        (_, child) => CodeFunctionReturnListConfig.forJavaLike(child);
    functionNameConfig ??=
        (_, child) => CodeFunctionNameConfig.forJavaLike(child);
    functionListConfig ??=
        (_, child) => CodeFunctionListConfig.forJavaLike(child);
    functionConfig ??= (_, child) => CodeFunctionConfig.forJavaLike(child);
    lambdaConfig ??= (_, child) => CodeLambdaConfig.forJavaLike(child);

    // Enum configs
    enumValueNameConfig ??=
        (_, child) => CodeEnumValueNameConfig.forJavaLike(child);
    enumValueListConfig ??=
        (_, child) => CodeEnumValueListConfig.forJavaLike(child);
    enumValueConfig ??= (_, child) => CodeEnumValueConfig.forJavaLike(child);
    enumNameConfig ??= (_, child) => CodeEnumNameConfig.forJavaLike(child);
    enumListConfig ??= (_, child) => CodeEnumListConfig.forJavaLike(child);
    enumConfig ??= (_, child) => CodeEnumConfig.forJavaLike(child);

    // Property Config
    propertyNameConfig ??=
        (_, child) => CodePropertyNameConfig.forJavaLike(child);
    propertyListConfig ??=
        (_, child) => CodePropertyListConfig.forJavaLike(child);
    propertyGetterConfig ??=
        (_, child) => CodePropertyGetterConfig.forJavaLike(child);
    propertySetterConfig ??=
        (_, child) => CodePropertySetterConfig.forJavaLike(child);
    propertyConfig ??= (_, child) => CodePropertyConfig.forJavaLike(child);

    // Interface configs
    interfaceListConfig ??=
        (_, child) => CodeInterfaceListConfig.forJavaLike(child);
    interfaceConfig ??= (_, child) => CodeInterfaceConfig.forJavaLike(child);

    // Class configs
    classNameConfig ??= (_, child) => CodeClassNameConfig.forJavaLike(child);
    classListConfig ??= (_, child) => CodeClassListConfig.forJavaLike(child);
    classConfig ??= (_, child) => CodeClassConfig.forJavaLike(child);
    classConstructorNameConfig ??=
        (_, child) => CodeConstructorNameConfig.forJavaLike(child);
    classConstructorListConfig ??=
        (_, child) => CodeConstructorListConfig.forJavaLike(child);
    classConstructorConfig ??=
        (_, child) => CodeConstructorConfig.forJavaLike(child);
    // Mixin & Extension configs
    // No support by default
  }

  @override
  Node buildOne(BuildContext context, Node child) {
    final configs = <CodeConfigBuildFunc<Node>>[
      indentConfig,
      blockConfig,
      codeAccessConfig,

      commentConfig,
      placeHolderConfig,

      // Package configs
      packageNameConfig,
      packageConfig,

      // Import Configs
      importConfig,
      importListConfig,
      importTypeConfig,

      // Type configs
      typeNameMapperConfig,
      typeNameConfig,
      typeConfig,
      typeListConfig,

      // Expr configs
      nullLiteralConfig,
      boolLiteralConfig,
      charLiteralConfig,
      stringLiteralConfig,
      numericLiteralConfig,
      arrayLiteralConfig,
      setLiteralConfig,
      mapLiteralConfig,
      cascadeConfig,
      spreadConfig,
      refConfig,
      varConfig,

      // Statement configs
      exprConfig,
      exprListConfig,
      statementListConfig,
      statementConfig,
      varNameConfig,
      ifConfig,
      elseIfConfig,
      returnConfig,
      forConfig,
      forEachConfig,
      whileConfig,
      functionCallConfig,
      constructorCallConfig,
      annotationListConfig,

      // Generic configs
      genericParamConfig,
      genericParamListConfig,

      // Field configs
      fieldNameConfig,
      fieldListConfig,
      fieldConfig,

      // Arg configs
      argNameConfig,
      argListConfig,
      argConfig,

      // Function configs
      functionThrowListConfig,
      functionThrowConfig,
      functionReturnConfig,
      functionReturnListConfig,
      functionNameConfig,
      functionListConfig,
      functionConfig,
      lambdaConfig,

      // Enum configs
      enumValueNameConfig,
      enumValueListConfig,
      enumValueConfig,
      enumNameConfig,
      enumListConfig,
      enumConfig,

      // Property configs
      propertyNameConfig,
      propertyListConfig,
      propertyGetterConfig,
      propertySetterConfig,
      propertyConfig,

      // Interface configs
      interfaceListConfig,
      interfaceConfig,

      // Class configs
      classNameConfig,
      classListConfig,
      classConfig,
      classConstructorNameConfig,
      classConstructorListConfig,
      classConstructorConfig,

      // Mixin configs
      mixinNameConfig,
      mixinListConfig,
      mixinConfig,

      // Extension configs
      extensionNameConfig,
      extensionListConfig,
      extensionConfig,
    ];

    for (final i in configs.reversed) {
      if (i != null) child = i(context, child);
    }

    return child;
  }
}
