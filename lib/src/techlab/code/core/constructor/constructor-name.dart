part of g3.techlab;

class CodeConstructorNameConfig extends CodeConfigNode<CodeConstructorName> {
  CodeConstructorNameConfig(
      NodeBuildFunc<CodeConstructorName> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeConstructorNameConfig.of(StringFunc func, Node child) =>
      CodeConstructorNameConfig(
          (context, name) => TextTransform(name.name, func), child);

  factory CodeConstructorNameConfig.forJavaLike(Node child) =>
      // Java does not allow named constructor, skip it.
      CodeConstructorNameConfig.of(StringFuncs.noop, child);

  factory CodeConstructorNameConfig.forDartLike(Node child) =>
      CodeConstructorNameConfig((context, name) {
        Node res = TextTransform(name.name, StringFuncs.camel);

        if (name.isPrivate == true || name.isProtected == true) {
          // Add '_' prefix for non public field.
          res = Pad.left('_', res, onlyIfMissing: true);
        }

        return res;
      }, child);
}

class CodeConstructorName extends CodeConfigProxyNode<CodeConstructorName>
    implements _NamedNode {
  @override
  final Node name;

  final bool isPrivate;

  final bool isProtected;

  CodeConstructorName._(this.name, this.isPrivate, this.isProtected);

  factory CodeConstructorName.of(dynamic value,
      {bool isPrivate, bool isProtected}) {
    if (value == null) return null;
    return CodeConstructorName._(Node.of(value), isPrivate, isProtected);
  }
}
