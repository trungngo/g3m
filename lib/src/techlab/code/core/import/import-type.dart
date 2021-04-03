part of g3.techlab;

class CodeImportTypeConfig extends CodeConfigNode<CodeImportType> {
  CodeImportTypeConfig(NodeBuildFunc<CodeImportType> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeImportTypeConfig.forJavaLike(
    Node child, {
    String importKeyword = 'import',
  }) =>
      CodeImportTypeConfig((context, import) {
        final package = context.dependOnAncestorNodeOfExactType<CodeImport>();
        return CodeExpr.open(
          Container([
            importKeyword,
            ' ',
            package.package ?? package.path,
            '.',
            import.type,
          ]),
        );
      }, child);
}

class CodeImportType extends CodeConfigProxyNode<CodeImportType> {
  final CodeTypeName type;
  final CodeTypeName alias;

  CodeImportType._({@required this.type, this.alias});

  factory CodeImportType.of({
    @required dynamic type,
    dynamic alias,
  }) =>
      CodeImportType._(
        type: CodeTypeName.of(type),
        alias: CodeTypeName.of(alias),
      );
}
