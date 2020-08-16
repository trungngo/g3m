part of g3.armory;

class CodeClassNameConfig extends CodeConfigNode<CodeClassName> {
  CodeClassNameConfig(NodeBuildFunc<CodeClassName> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeClassNameConfig.of(StringFunc func, Node child) =>
      CodeClassNameConfig(
          (context, name) => TextTransform(name.content, func), child);

  factory CodeClassNameConfig.forJavaLike(Node child) =>
      CodeClassNameConfig.of(StringFuncs.pascal, child);

  factory CodeClassNameConfig.forDartLike(Node child) =>
      CodeClassNameConfig((context, name) {
        final clazz = context.findAncestorNodeOfExactType<CodeClass>();
        final modifier = clazz?.modifier;

        Node res = TextTransform(name.content, StringFuncs.pascal);

        if (modifier?.private == true ||
            modifier?.protected == true ||
            modifier?.internal == true) {
          // Add '_' prefix for non public clazz.
          res = Pad.left('_', res);
        }

        return res;
      }, child);
}

class CodeClassName extends CodeConfigProxyNode<CodeClassName> {
  final Node content;

  CodeClassName(this.content);

  factory CodeClassName.of(String text) {
    return text == null ? null : CodeClassName(Text.of(text));
  }
}
