part of g3.techlab.xml;

/// Defines a dart code fine.
/// This help to enforce the dart syntax and [DatCode] will
/// be automatically added in the node tree.
///
class XmlCodeFile implements Node {
  static const String syntax = 'xml';
  static const String extension = 'xml';

  /// The file name without extension.
  final String name;

  /// The file content.
  final Node source;

  /// True indicates that the file need to be overwrite all the time.
  /// False indicates that the file never get overwrite.
  /// null indicates that needs human confirm.
  final bool overwriteIfExists;

  XmlCodeFile(this.name, {this.source, this.overwriteIfExists});

  factory XmlCodeFile.of(
    String name, {
    @meta.required String rootName,
    @meta.required dynamic body,
    Map<String, dynamic> attributes,
    bool overwriteIfExists,
  }) {
    assert(name != null);
    assert(rootName != null);
    return XmlCodeFile(
      name,
      source: Container([
        '<?xml version="1.0" encoding="UTF-8"?>\n',
        XmlElement(
          rootName,
          attributes: attributes,
          body: body,
        ),
      ]),
      overwriteIfExists: overwriteIfExists,
    );
  }

  @override
  Node build(BuildContext context) {
    return CodeFile(
      name: name,
      extension: extension,
      syntax: syntax,
      source: XmlCode(source),
      overwriteIfExists: overwriteIfExists,
    );
  }
}

class XmlElement implements Node {
  final String name;
  final Map<String, dynamic> attributes;
  final Node body;

  XmlElement._(this.name, {this.attributes, this.body});

  static Node _parseBody(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<Node>(value, (v) {
      if (v == null) {
        return CodeNullLiteral();
      } else if (value is bool) {
        return CodeBoolLiteral.of(value);
      } else if (value is String) {
        return CodeStringLiteral.of(value);
      } else if (value is num) {
        return CodeNumericLiteral.of(value);
      } else if (value is List<dynamic>) {
        return CodeArrayLiteral.of(value);
      } else if (value is Map<String, dynamic>) {
        return CodeMapLiteral.of(value);
      } else if (value is XmlElement) {
        return v;
      } else {
        return Text(v);
      }
    }, error: error);
  }

  factory XmlElement(
    String name, {
    Map<String, dynamic> attributes,
    dynamic body,
  }) {
    return XmlElement._(name,
        attributes: attributes, body: XmlElement._parseBody(body));
  }

  @override
  Node build(BuildContext context) {
    final pairs = attributes?.entries?.map(
      (e) {
        final k = e.key;
        return Container([
          ' ',
          k,
          '="',
          e.value,
          '"',
        ]);
      },
    )?.toList();

    return Container([
      '<',
      name,
      pairs,
      '>',
      body,
      '</',
      name,
      '>\n',
    ]);
  }
}

class XmlCode extends SingleChildNode {
  XmlCode(Node source) : super(XmlCodeConfig(source));
}

class XmlCodeConfig extends ExactlyOneNode<XmlCodeConfig> {
  CodeConfigBuildFunc<IndentConfig> indentConfig;
  CodeConfigBuildFunc<CodeBlockConfig> blockConfig;
  CodeConfigBuildFunc<CodeCommentConfig> commentConfig;
  CodeConfigBuildFunc<CodePlaceHolderConfig> placeHolderConfig;

  //
  CodeConfigBuildFunc<CodeNullLiteralConfig> nullLiteralConfig;
  CodeConfigBuildFunc<CodeBoolLiteralConfig> boolLiteralConfig;
  CodeConfigBuildFunc<CodeCharLiteralConfig> charLiteralConfig;
  CodeConfigBuildFunc<CodeStringLiteralConfig> stringLiteralConfig;
  CodeConfigBuildFunc<CodeNumericLiteralConfig> numericLiteralConfig;
  CodeConfigBuildFunc<CodeArrayLiteralConfig> arrayLiteralConfig;
  CodeConfigBuildFunc<CodeSetLiteralConfig> setLiteralConfig;
  CodeConfigBuildFunc<CodeMapLiteralConfig> mapLiteralConfig;

  // expressions
  CodeConfigBuildFunc<CodeExprConfig> exprConfig;
  CodeConfigBuildFunc<CodeExprListConfig> exprListConfig;

  XmlCodeConfig(
    Node child, {
    this.indentConfig,
    this.blockConfig,
    this.commentConfig,
    this.placeHolderConfig,
    //
    this.nullLiteralConfig,
    this.boolLiteralConfig,
    this.charLiteralConfig,
    this.stringLiteralConfig,
    this.numericLiteralConfig,
    this.arrayLiteralConfig,
    this.setLiteralConfig,
    this.mapLiteralConfig,
    //
    this.exprConfig,
    this.exprListConfig,
  }) : super(child) {
    indentConfig ??= (_, child) => IndentConfig.useSpace4(child);
    blockConfig ??= (_, child) => CodeBlockConfig.indent(child);
    commentConfig ??= (_, child) => CodeCommentConfig.forXml(child);
    placeHolderConfig ??= (_, child) => CodePlaceHolderConfig.forXml(child);
    // Expr configs
    nullLiteralConfig ??= (_, child) => CodeNullLiteralConfig.forXml(child);
    boolLiteralConfig ??=
        (_, child) => CodeBoolLiteralConfig.forJavaLike(child);
    charLiteralConfig ??=
        (_, child) => CodeCharLiteralConfig.forJavaLike(child);
    stringLiteralConfig ??=
        (_, child) => CodeStringLiteralConfig.forYamlLike(child);
    numericLiteralConfig ??=
        (_, child) => CodeNumericLiteralConfig.forJavaLike(child);
    arrayLiteralConfig ??= (_, child) => CodeArrayLiteralConfig.forXml(child);
    setLiteralConfig ??= (_, child) => CodeSetLiteralConfig.forJavaLike(child);
    mapLiteralConfig ??= (_, child) => CodeMapLiteralConfig.forXml(child);

    // statements
    // TODO Fix
    exprConfig ??= (_, child) => CodeExprConfig.forJavaLike(child);
    exprListConfig ??= (_, child) => CodeExprListConfig.forJavaLike(child);
  }

  @override
  Node buildOne(BuildContext context, Node child) {
    final configs = <CodeConfigBuildFunc<Node>>[
      indentConfig,
      blockConfig,
      commentConfig,
      placeHolderConfig,
      // Expr configs
      nullLiteralConfig,
      boolLiteralConfig,
      charLiteralConfig,
      stringLiteralConfig,
      numericLiteralConfig,
      arrayLiteralConfig,
      setLiteralConfig,
      mapLiteralConfig,
      //
      exprConfig,
      exprListConfig,
    ];

    for (final i in configs.reversed) {
      if (i != null) child = i(context, child);
    }

    return child;
  }
}
