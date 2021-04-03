part of g3.techlab;

/// Provides configuration for how [CodeBlock] node will render.
///
/// Here are some useful predefined factory methods
/// [CodeBlockConfig.curlyBracketSameLine],
/// [CodeBlockConfig.curlyBracketNewLine], [CodeBlockConfig.colonIndent]) that
/// might work for many existing programming languages.
///
/// Notes that this [IndentConfig] is required ancestor of this node.
/// See [DartCodeConfig] to see how this configuration is used for dart language.
///
class CodeBlockConfig extends CodeConfigNode<CodeBlock> {
  CodeBlockConfig(NodeBuildFunc<CodeBlock> buildFunc, Node child)
      : super(buildFunc, child);

  /// Creates a code block config for language like java, dart, ...
  factory CodeBlockConfig.curlyBracketSameLine(Node child) =>
      CodeBlockConfig.openCloseIndent('{', '}', false, child);

  /// Creates a code block config for language like csharp
  factory CodeBlockConfig.curlyBracketNewLine(Node child) =>
      CodeBlockConfig.openCloseIndent('{', '}', true, child);

  /// Creates a code block config for language like markdown
  factory CodeBlockConfig.colonIndent(Node child) =>
      CodeBlockConfig.openCloseIndent(':', null, false, child);

  /// Creates a code block config for language like markdown
  factory CodeBlockConfig.indent(Node child) =>
      CodeBlockConfig.openCloseIndent(null, null, false, child);

  /// Creates a code block config for any language that might
  /// require a weird open/close and indent syntax.
  factory CodeBlockConfig.openCloseIndent(
      String open, String close, bool newLine, Node child) {
    return CodeBlockConfig((context, codeBlock) {
      var body = codeBlock.body;
      if (body == null ||
          body is CodeStatementList && body.statements?.isNotEmpty != true) {
        // TODO: Handle this case better when the rendered body is empty text.
        return _RawText('${open}${close}');
      }
      return Container([
        newLine ? '\n' : null,
        open,
        '\n',
        Indent(body),
        '\n',
        close,
      ]);
    }, child);
  }

  static CodeBlockConfig of(BuildContext context) {
    return context.dependOnAncestorNodeOfExactType<CodeBlockConfig>();
  }
}

/// Defines a code block such as class body, function body, etc.
///
/// Important: [CodeBlockConfig] is a required ancestor for this node.
///
class CodeBlock extends CodeConfigProxyNode<CodeBlock> {
  final Node body;

  CodeBlock._(this.body);

  factory CodeBlock.of(Node body) => body != null ? CodeBlock._(body) : null;
}
