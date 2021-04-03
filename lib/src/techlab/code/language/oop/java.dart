part of g3.techlab.java;

/// Defines a dart code fine.
/// This help to enforce the dart syntax and [DatCode] will
/// be automatically added in the node tree.
///
class JavaCodeFile implements Node {
  static const String syntax = 'java';
  static const String defaultExtension = 'java';

  /// The file name without extension.
  final String name;
  final String extension;

  /// The file content.
  final Node source;

  /// True indicates that the file need to be overwrite all the time.
  /// False indicates that the file never get overwrite.
  /// null indicates that needs human confirm.
  final bool overwriteIfExists;

  JavaCodeFile._(
    this.name, {
    this.extension,
    this.source,
    this.overwriteIfExists,
  });

  factory JavaCodeFile.ofClass(
    String name,
    CodeClass clazz, {
    String extension,
    CodePackage package,
    dynamic comment,
    List<CodeImport> imports,
    dynamic body,
  }) {
    return JavaCodeFile.of(
      name,
      extension: extension,
      comment: CodeComment.of(comment),
      package: package,
      imports: imports,
      classes: [clazz],
      body: body,
    );
  }

  factory JavaCodeFile.ofInterface(
    String name,
    CodeInterface interface, {
    String extension,
    CodePackage package,
    dynamic comment,
    List<CodeImport> imports,
    dynamic body,
  }) {
    return JavaCodeFile.of(
      name,
      extension: extension,
      comment: CodeComment.of(comment),
      package: package,
      imports: imports,
      interfaces: [interface],
      body: body,
    );
  }

  factory JavaCodeFile.ofEnum(
    String name,
    CodeEnum e, {
    String extension,
    CodePackage package,
    CodeComment comment,
    List<CodeImport> imports,
    dynamic body,
  }) {
    return JavaCodeFile.of(
      name,
      extension: extension,
      comment: comment,
      package: package,
      imports: imports,
      enums: [e],
    );
  }

  factory JavaCodeFile.of(
    String name, {
    String extension,
    CodePackage package,
    dynamic comment,
    List<CodeImport> imports,
    List<CodeEnum> enums,
    List<CodeFunction> functions,
    List<CodeInterface> interfaces,
    List<CodeClass> classes,
    dynamic body,
  }) {
    // Node that java code expect the file name to be class name.
    return JavaCodeFile._(
      name.pascalCase,
      extension: extension ?? defaultExtension,
      source: JavaCode.of(
          package: package,
          comment: CodeComment.of(comment),
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
    return JavaCodeConfig(
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

class JavaCode extends SingleChildNode {
  JavaCode(Node source) : super(JavaCodeConfig(source));

  factory JavaCode.of({
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
          CodeInterfaceList.of(interfaces),
          CodeClassList.of(classes),
        ]),
      ),
      CodeStatementList.of(body),
    ]);
    // Node that java code expect the file name to be class name.
    return JavaCode(source);
  }
}

/// Defines global configuration for java code generation.
///
class JavaCodeConfig extends OopCodeConfig<JavaCodeConfig> {
  JavaCodeConfig(Node child)
      : super(
          child,
          indentConfig: (_, child) => IndentConfig.useSpace4(child),
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
          // https://www.tutorialspoint.com/java/java_basic_datatypes.htm
          typeNameMapperConfig: (_, child) => CodeTypeNameMapperConfig.of(child,
              tDynamic: 'Object',
              tVoid: 'void',
              tBool: 'Boolean',
              tChar: 'Char',
              tString: 'String',
              tByte: 'Byte',
              tShort: 'Short',
              tInteger: 'Integer',
              tLong: 'Long',
              tFloat: 'Float',
              tDouble: 'Double',
              others: {
                'int': 'Integer',
                'boolean': 'boolean',
              }),

          typeNameConfig: null,
          typeConfig: null,
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
          varConfig: null,

          // Statement configs
          exprConfig: null,
          exprListConfig: null,
          statementListConfig: null,
          statementConfig: null,
          varNameConfig: null,
          ifConfig: null,
          elseIfConfig: null,
          returnConfig: null,
          whileConfig: null,
          forConfig: null,
          forEachConfig: null,
          functionCallConfig: null,
          constructorCallConfig: null,
          annotationListConfig: null,

          // Generic configs
          genericParamConfig: null,
          genericParamListConfig: null,

          // Field configs
          fieldNameConfig: null,
          fieldListConfig: null,
          fieldConfig: null,

          // Arg configs
          argNameConfig: null,
          argListConfig: null,
          argConfig: null,

          // Function configs
          functionThrowListConfig: null,
          functionThrowConfig: null,
          functionReturnConfig: null,
          functionReturnListConfig: null,
          functionNameConfig: null,
          functionListConfig: null,
          functionConfig: null,
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
          propertyGetterConfig: null,
          propertySetterConfig: null,
          propertyConfig: null,

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
