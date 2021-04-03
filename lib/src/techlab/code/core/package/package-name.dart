part of g3.techlab;

class CodePackageNameConfig extends CodeConfigNode<CodePackageName> {
  CodePackageNameConfig(NodeBuildFunc<CodePackageName> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodePackageNameConfig.forTypescriptLike(Node child) =>
      // Don't handle anything special for dart name
      CodePackageNameConfig.of(child, nameFunc: StringFuncs.camel);

  factory CodePackageNameConfig.forDartLike(Node child) =>
      // Don't handle anything special for dart name
      CodePackageNameConfig.of(child);

  factory CodePackageNameConfig.forJavaLike(Node child) =>
      CodePackageNameConfig.of(child);

  factory CodePackageNameConfig.noSupport(Node child) => CodePackageNameConfig(
      (context, expr) => throw ('package syntax is not available.'), child);

  factory CodePackageNameConfig.of(
    Node child, {
    StringFunc nameFunc,
  }) {
    nameFunc ??= StringFuncs.snake;

    return CodePackageNameConfig((context, name) {
      return TextTransform(name.name, nameFunc);
    }, child);
  }
}

class CodePackageName extends CodeConfigProxyNode<CodePackageName>
    implements _NamedNode {
  @override
  final Node name;

  CodePackageName._(this.name);

  static CodePackageName _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodePackageName>(value, (v) {
      // Try to parse the value as the expression name.
      final name = _parseNameNode(v, error: error);
      if (name == null) return null;
      return CodePackageName._(name);
    }, error: error);
  }

  factory CodePackageName.of(dynamic value) {
    return CodePackageName._parse(value, error: () {
      throw '${value} is not a valid package name.';
    });
  }

  // FIXME should parse
  static List<CodePackageName> listOf(List<dynamic> texts) {
    if (texts?.isNotEmpty != true) return null;
    return texts.map((e) => CodePackageName.of(e)).toList();
  }
}
