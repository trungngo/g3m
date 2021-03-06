part of g3.techlab.json;

/// Defines a dart code fine.
/// This help to enforce the dart syntax and [DatCode] will
/// be automatically added in the node tree.
///
class JsonCodeFile implements Node {
  static const String syntax = 'json';
  static const String extension = 'json';

  /// The file name without extension.
  final String name;

  /// The file content.
  final CodeMapLiteral source;

  /// True indicates that the file need to be overwrite all the time.
  /// False indicates that the file never get overwrite.
  /// null indicates that needs human confirm.
  final bool overwriteIfExists;

  JsonCodeFile(this.name, {this.source, this.overwriteIfExists});

  factory JsonCodeFile.of(
    String name, {
    Map<String, dynamic> body,
  }) {
    return JsonCodeFile(name, source: CodeMapLiteral.of(body));
  }

  @override
  Node build(BuildContext context) {
    return CodeFile(
      name: name,
      extension: extension,
      syntax: syntax,
      source: JsonCode(source),
      overwriteIfExists: overwriteIfExists,
    );
  }
}

class JsonCode extends ExactlyOneNode<JsonCode> {
  JsonCode(Node child) : super(child);

  @override
  Node buildOne(BuildContext context, Node child) {
    return IndentConfig.useSpace2(
      CodeBlockConfig.curlyBracketSameLine(
        _buildExprConfig(
          child,
        ),
      ),
    );
  }

  Node _buildExprConfig(Node child) {
    return CodeNullLiteralConfig.forJavaLike(
      CodeBoolLiteralConfig.forJavaLike(
        CodeCharLiteralConfig.forJavaLike(
          CodeStringLiteralConfig.forJavaLike(
            CodeNumericLiteralConfig.forJavaLike(
              CodeExprConfig.forJavaLike(
                CodeArrayLiteralConfig.forJavaLike(
                  CodeMapLiteralConfig.forJavaLike(
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
