part of g3.techlab;

class CodeEnumValueNameConfig extends CodeConfigNode<CodeEnumValueName> {
  CodeEnumValueNameConfig(
      NodeBuildFunc<CodeEnumValueName> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeEnumValueNameConfig.forJavaLike(Node child) =>
      CodeEnumValueNameConfig._internal(child);

  factory CodeEnumValueNameConfig.forTypescriptLike(Node child) =>
      CodeEnumValueNameConfig._internal(
        child,
        func: StringFuncs.pascal,
      );

  factory CodeEnumValueNameConfig.forDartLike(Node child) =>
      CodeEnumValueNameConfig._internal(
        child,
        func: StringFuncs.camel,
        privatePrefix: '_',
      );

  factory CodeEnumValueNameConfig._internal(
    Node child, {
    StringFunc func,
    String privatePrefix = '',
  }) {
    func ??= StringFuncs.constant;
    return CodeEnumValueNameConfig((_, arg) {
      return Container([
        arg.isPrivate == true ? privatePrefix : null,
        TextTransform(arg.name, func),
      ]);
    }, child);
  }
}

/// Defines a name for [CodeEnumValue] element.
///
class CodeEnumValueName extends CodeConfigProxyNode<CodeEnumValueName>
    implements _NamedNode {
  @override
  final Node name;

  /// True indicates this field name is private.
  final bool isPrivate;

  CodeEnumValueName._({
    @required this.name,
    @required this.isPrivate,
  }) : assert(name != null);

  static CodeEnumValueName _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeEnumValueName>(value, (v) {
      // Try to parse the value as the expression name.
      final name = _parseNameNode(v, error: error);
      if (name == null) return null;
      return CodeEnumValueName._(
        name: name,
        isPrivate: null,
      );
    }, error: error);
  }

  factory CodeEnumValueName.of({
    @required dynamic name,
    bool isPrivate,
  }) {
    return CodeEnumValueName._(
      name: _parseNameNode(name, error: () {
        throw '$name is an invalid enum value name';
      }),
      isPrivate: isPrivate,
    );
  }
}
