part of g3.techlab.yaml;

/// Defines a dart code fine.
/// This help to enforce the dart syntax and [DatCode] will
/// be automatically added in the node tree.
///
class YmlCodeFile implements Node {
  static const String syntax = 'yaml';
  static const String extension = 'yml';

  /// The file name without extension.
  final String name;

  /// The file content.
  final CodeMapLiteral source;

  /// True indicates that the file need to be overwrite all the time.
  /// False indicates that the file never get overwrite.
  /// null indicates that needs human confirm.
  final bool overwriteIfExists;

  YmlCodeFile(this.name, {this.source, this.overwriteIfExists});

  factory YmlCodeFile.of(
    String name, {
    Map<String, dynamic> body,
    bool overwriteIfExists,
  }) {
    return YmlCodeFile(
      name,
      source: CodeMapLiteral.of(body),
      overwriteIfExists: overwriteIfExists,
    );
  }

  @override
  Node build(BuildContext context) {
    return CodeFile(
      name: name,
      extension: extension,
      syntax: syntax,
      source: YmlCode(source),
      overwriteIfExists: overwriteIfExists,
    );
  }
}

class YmlCode extends ExactlyOneNode<YmlCode> {
  YmlCode(Node child) : super(child);

  @override
  Node buildOne(BuildContext context, Node child) {
    return IndentConfig.useSpace2(
      CodeBlockConfig.colonIndent(
        _buildExprConfig(
          child,
        ),
      ),
    );
  }

  Node _buildExprConfig(Node child) {
    return CodeNullLiteralConfig.forJavaLike(
      CodeStringLiteralConfig.forYamlLike(
        CodeBoolLiteralConfig.forJavaLike(
          CodeCharLiteralConfig.forJavaLike(
            CodeNumericLiteralConfig.forJavaLike(
              CodeExprConfig.forJavaLike(
                CodeArrayLiteralConfig.forYmlLike(
                  CodeMapLiteralConfig.forYmlLike(
                    child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
