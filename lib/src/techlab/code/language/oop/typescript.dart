part of g3.techlab.typescript;

/// Defines a typescript code fine.
/// This help to enforce the typescript syntax and [TypescriptCodeConfig] will
/// be automatically added in the node tree.
///
class TypescriptCodeFile implements Node {
  static const String syntax = 'typescript';
  static const String defaultExtension = 'ts';

  /// The file name without extension.
  final String name;
  final String extension;

  /// The file content.
  final Node source;

  /// True indicates that the file need to be overwrite all the time.
  /// False indicates that the file never get overwrite.
  /// null indicates that needs human confirm.
  final bool overwriteIfExists;

  TypescriptCodeFile._(
    this.name, {
    this.source,
    this.overwriteIfExists,
    this.extension,
  });

  factory TypescriptCodeFile.of(
    String name, {
    String extension,
    CodePackage package,
    dynamic comment,
    Iterable<CodeImport> imports,
    Iterable<CodeEnum> enums,
    Iterable<CodeFunction> functions,
    Iterable<CodeInterface> interfaces,
    Iterable<CodeClass> classes,
    bool overwriteIfExists,
    dynamic body,
  }) {
    // Node that java code expect the file name to be class name.
    return TypescriptCodeFile._(
      name,
      extension: extension ?? defaultExtension,
      overwriteIfExists: overwriteIfExists,
      source: TypescriptCode.of(
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
    return TypescriptCodeConfig(
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

class TypescriptCode extends SingleChildNode {
  TypescriptCode._(Node source) : super(TypescriptCodeConfig(source));

  factory TypescriptCode.of({
    dynamic package,
    dynamic comment,
    dynamic enums,
    dynamic imports,
    dynamic functions,
    dynamic interfaces,
    dynamic classes,
    dynamic body,
  }) {
    final source = Container([
      CodeStatement.of(
        Container([
          CodeComment.of(comment),
          package,
          CodeImportList.of(imports),
          CodeEnumList.of(enums),
          CodeFunctionList.of(functions),
          CodeInterfaceList.of(interfaces),
          CodeClassList.of(classes),
        ]),
      ),
      CodeStatementList.of(body),
    ]);

    // Node that java code expect the file name to be class name.
    return TypescriptCode._(source);
  }
}

/// Defines global configuration for java code generation.
///
class TypescriptCodeConfig extends OopCodeConfig<TypescriptCodeConfig> {
  TypescriptCodeConfig(Node child)
      : super(
          child,
          indentConfig: null,
          blockConfig: null,
          codeAccessConfig: (_, child) =>
              CodeModifierConfig.forTypescriptLike(child),

          commentConfig: null,
          placeHolderConfig: null,

          // Package configs
          packageNameConfig: (_, child) =>
              CodePackageNameConfig.forTypescriptLike(child),
          packageConfig: (_, child) => CodePackageConfig.noSupport(child),

          // Import Configs
          importConfig: (_, child) => CodeImportConfig.forTypescriptLike(child),
          importListConfig: null,
          importTypeConfig: null,

          // Type configs

          typeNameMapperConfig: (_, child) => CodeTypeNameMapperConfig.of(child,
              tDynamic: 'any',
              tVoid: 'void',
              tBool: 'boolean',
              tChar: 'string',
              tString: 'string',
              tByte: 'number',
              tShort: 'number',
              tInteger: 'number',
              tLong: 'number',
              tFloat: 'number',
              tDouble: 'number',
              others: {
                // Typescript primitive types need to be lower case
                'unknown': 'unknown',
                'number': 'number',
                'bigint': 'bigint',
              }),
          typeNameConfig: null,
          typeConfig: (_, child) => CodeTypeConfig.forTypescriptLike(child),
          typeListConfig: null,

          // Expr configs
          nullLiteralConfig: null,
          boolLiteralConfig: null,
          charLiteralConfig: null,
          stringLiteralConfig: (_, child) =>
              CodeStringLiteralConfig.forDartLike(child),
          numericLiteralConfig: null,
          arrayLiteralConfig: null,
          setLiteralConfig: null,
          mapLiteralConfig: null,
          cascadeConfig: (_, child) => CodeCascadeConfig.noSupport(child),
          spreadConfig: (_, child) => CodeSpreadConfig.forDartLike(child),
          refConfig: null,
          varConfig: (_, child) => CodeVarConfig.forTypescript(child),

          // Statement configs
          exprConfig: null,
          exprListConfig: (_, child) =>
              CodeExprListConfig.forTypescriptLike(child),
          statementListConfig: null,
          statementConfig: null,
          varNameConfig: null,
          ifConfig: null,
          elseIfConfig: null,
          returnConfig: null,
          forConfig: null,
          forEachConfig: (_, child) => CodeForEachConfig.forDartLike(child),
          whileConfig: null,
          functionCallConfig: null,
          constructorCallConfig: null,
          annotationListConfig: null,

          // Generic configs
          genericParamConfig: null,
          genericParamListConfig: null,

          // Field configs
          fieldNameConfig: null,
          fieldListConfig: null,
          fieldConfig: (_, child) => CodeFieldConfig.forTypescriptLike(child),

          // Arg configs
          argNameConfig: null,
          argListConfig: null,
          argConfig: (_, child) => CodeArgConfig.forTypescriptLike(child),

          // Function configs
          functionThrowListConfig: (_, child) =>
              CodeFunctionThrowListConfig.ignored(child),
          functionThrowConfig: (_, child) =>
              CodeFunctionThrowConfig.ignored(child),
          functionReturnConfig: (_, child) =>
              CodeFunctionReturnConfig.forJavaLike(child),
          functionReturnListConfig: null,
          functionNameConfig: (_, child) =>
              CodeFunctionNameConfig.forJavaLike(child),
          functionListConfig: null,
          functionConfig: (_, child) =>
              CodeFunctionConfig.forTypescriptLike(child),
          lambdaConfig: null,

          // Enum configs,
          enumValueNameConfig: (_, child) =>
              CodeEnumValueNameConfig.forTypescriptLike(child),
          enumValueListConfig: null,
          enumValueConfig: null,
          enumNameConfig: null,
          enumListConfig: null,
          enumConfig: null,

          // Property configs
          propertyNameConfig: null,
          propertyListConfig: null,
          propertyGetterConfig: (_, child) =>
              CodePropertyGetterConfig.forTypescriptLike(child),
          propertySetterConfig: (_, child) =>
              CodePropertySetterConfig.forTypescriptLike(child),
          propertyConfig: (_, child) =>
              CodePropertyConfig.forTypescriptLike(child),

          // Interface configs
          interfaceListConfig: null,
          interfaceConfig: (_, child) =>
              CodeInterfaceConfig.forTypescriptLike(child),

          // Class configs
          classNameConfig: null,
          classListConfig: null,
          classConfig: null,
          classConstructorNameConfig: null,
          classConstructorListConfig: null,
          classConstructorConfig: (_, child) =>
              CodeConstructorConfig.forTypescriptLike(child),

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
