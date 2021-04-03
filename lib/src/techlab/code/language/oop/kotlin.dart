part of g3.techlab.kotlin;

/// Defines a dart code fine.
/// This help to enforce the dart syntax and [DatCode] will
/// be automatically added in the node tree.
///
class KotlinCodeFile implements Node {
  static const String syntax = 'kotlin';
  static const String defaultExtension = 'kt';

  /// The file name without extension.
  final String name;
  final String extension;

  /// The file content.
  final Node source;

  /// True indicates that the file need to be overwrite all the time.
  /// False indicates that the file never get overwrite.
  /// null indicates that needs human confirm.
  final bool overwriteIfExists;

  KotlinCodeFile._(
    this.name, {
    this.extension,
    this.source,
    this.overwriteIfExists,
  });

  factory KotlinCodeFile.of(
    String name, {
    String extension,
    CodePackage package,
    CodeComment comment,
    List<CodeImport> imports,
    List<CodeEnum> enums,
    List<CodeFunction> functions,
    List<CodeInterface> interfaces,
    List<CodeClass> classes,
    Node body,
  }) {
    // Node that java code expect the file name to be class name.
    return KotlinCodeFile._(
      name,
      extension: extension ?? defaultExtension,
      source: KotlinCode.of(
          package: package,
          comment: comment,
          imports: imports,
          enums: enums,
          functions: functions,
          interfaces: interfaces,
          classes: classes,
          body: body),
    );
  }

  @override
  Node build(BuildContext context) {
    return KotlinCodeConfig(
      CodeFile(
        name: name,
        extension: extension,
        syntax: syntax,
        source: source,
        overwriteIfExists: overwriteIfExists,
      ),
    );
  }
}

class KotlinCode extends SingleChildNode {
  KotlinCode(Node source) : super(KotlinCodeConfig(source));

  factory KotlinCode.of({
    dynamic package,
    dynamic comment,
    dynamic imports,
    dynamic enums,
    dynamic functions,
    dynamic interfaces,
    dynamic classes,
    dynamic body,
  }) {
    final source = Container([
      CodeStatement.of(
        Container([
          comment,
          package,
          CodeImportList.of(imports),
          CodeEnumList.of(enums),
          CodeFunctionList.of(functions),
          CodeClassList.of(classes),
        ]),
      ),
      CodeStatementList.of(body),
    ]);
    // Node that java code expect the file name to be class name.
    return KotlinCode(source);
  }
}

/// Defines global configuration for java code generation.
///
class KotlinCodeConfig extends OopCodeConfig<KotlinCodeConfig> {
  KotlinCodeConfig(Node child)
      : super(
          child,
          indentConfig: null,
          blockConfig: null,
          codeAccessConfig: null,

          commentConfig: null,
          placeHolderConfig: null,

          // Package configs
          packageNameConfig: null,
          packageConfig: null,

          // Import Configs
          importConfig: null,
          importListConfig: null,
          importTypeConfig: null,

          // Type configs
          // https://kotlinlang.org/docs/reference/basic-types.html
          typeNameMapperConfig: (_, child) => CodeTypeNameMapperConfig.of(
            child,
            tDynamic: 'Any',
            tVoid: 'void',
            tBool: 'Boolean',
            tChar: 'Char',
            tString: 'String',
            tByte: 'Byte',
            tShort: 'Short',
            tInteger: 'Int',
            tLong: 'Long',
            tFloat: 'Float',
            tDouble: 'Double',
          ),
          typeNameConfig: null,
          typeConfig: (_, child) => CodeTypeConfig.forKotlinLike(child),
          typeListConfig: null,

          // Expr configs
          nullLiteralConfig: null,
          boolLiteralConfig: null,
          charLiteralConfig: null,
          stringLiteralConfig: null,
          numericLiteralConfig: null,
          arrayLiteralConfig: null,
          setLiteralConfig: null,
          mapLiteralConfig: null,
          cascadeConfig: null,
          spreadConfig: null,
          refConfig: null,
          varConfig: (_, child) => CodeVarConfig.forKotlin(child),

          // Statement configs
          exprConfig: null,
          exprListConfig: (_, child) => CodeExprListConfig.forKotlinLike(child),
          statementListConfig: null,
          statementConfig: null,
          varNameConfig: null,
          ifConfig: null,
          elseIfConfig: null,
          returnConfig: null,
          whileConfig: null,
          forConfig: null,
          forEachConfig: (_, child) => CodeForEachConfig.forKotlin(child),
          functionCallConfig: null,
          constructorCallConfig: null,
          annotationListConfig: null,

          // Generic configs
          genericParamConfig: null,
          genericParamListConfig: null,

          // Field configs
          fieldNameConfig: null,
          fieldListConfig: null,
          fieldConfig: (_, child) => CodeFieldConfig.forKotlinLike(child),

          // Arg configs
          argNameConfig: null,
          argListConfig: null,
          argConfig: (_, child) => CodeArgConfig.forKotlin(child),

          // Function configs
          functionThrowListConfig: null,
          functionThrowConfig: null,
          functionReturnConfig: null,
          functionReturnListConfig: null,
          functionNameConfig: null,
          functionListConfig: null,
          functionConfig: (_, sub) => CodeFunctionConfig.forKotlinLike(sub),
          lambdaConfig: null,

          // Enum configs,
          enumValueNameConfig: null,
          enumValueListConfig: null,
          enumValueConfig: null,
          enumNameConfig: null,
          enumListConfig: null,
          enumConfig: null,

          // Property configs
          propertyNameConfig: null,
          propertyListConfig: null,
          propertyGetterConfig: (_, child) =>
              CodePropertyGetterConfig.forKotlinLike(child),
          propertySetterConfig: (_, child) =>
              CodePropertySetterConfig.forKotlinLike(child),
          propertyConfig: (_, child) => CodePropertyConfig.forKotlinLike(child),

          // Interface configs
          interfaceListConfig: null,
          interfaceConfig: null,

          // Class configs

          classNameConfig: null,
          classListConfig: null,
          classConfig: null,
          classConstructorNameConfig: null,
          classConstructorListConfig: null,
          classConstructorConfig: null,

          // Mixin configs
          mixinNameConfig: null,
          mixinListConfig: null,
          mixinConfig: null,

          // Extension config
          extensionNameConfig: null,
          extensionListConfig: null,
          extensionConfig: null,
        );
}
