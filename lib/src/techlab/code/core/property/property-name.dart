part of g3.techlab;

class CodePropertyNameConfig extends CodeConfigNode<CodePropertyName> {
  CodePropertyNameConfig(NodeBuildFunc<CodePropertyName> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodePropertyNameConfig.of(StringFunc func, Node child) =>
      CodePropertyNameConfig(
          (context, name) => TextTransform(name.name, func), child);

  factory CodePropertyNameConfig.forDartLike(Node child) =>
      CodePropertyNameConfig((context, name) {
        final property = context.findAncestorNodeOfExactType<CodeProperty>();
        final modifier = property?.modifier;

        Node res = TextTransform(name.name, StringFuncs.camel);

        if (modifier?.isPrivate == true ||
            modifier?.isProtected == true ||
            modifier?.isInternal == true) {
          // Add '_' prefix for non public property.
          res = Pad.left('_', res, onlyIfMissing: true);
        }

        return res;
      }, child);

  factory CodePropertyNameConfig.forJavaLike(Node child) =>
      CodePropertyNameConfig.of(StringFuncs.camel, child);
}

class CodePropertyName extends CodeConfigProxyNode<CodePropertyName>
    implements _NamedNode {
  @override
  final Node name;

  CodePropertyName._(this.name);

  factory CodePropertyName.of(dynamic text) {
    return parseNode<CodePropertyName>(text, (v) {
      if (v is CodeField) return CodePropertyName._(v.name.name);
      if (v is CodeFieldName) return CodePropertyName._(v.name);
      return CodePropertyName._(Text(v));
    });
  }
}
