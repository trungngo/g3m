part of g3.techlab;

class CodeTypeNameMapperConfig extends SingleChildNode {
  final Map<String, String> map;

  CodeTypeNameMapperConfig(Node child, this.map)
      : assert(map != null),
        super(child);

  factory CodeTypeNameMapperConfig.of(
    Node child, {
    String tDynamic,
    String tVoid,
    String tBool,
    String tChar,
    String tString,
    String tByte,
    String tShort,
    String tInteger,
    String tLong,
    String tFloat,
    String tDouble,
    Map<String, String> others,
  }) {
    final data = <String, String>{};

    if (tDynamic != null) data[CodeType._dynamic] = tDynamic;
    if (tVoid != null) data[CodeType._void] = tVoid;
    if (tBool != null) data[CodeType._bool] = tBool;
    if (tChar != null) data[CodeType._char] = tChar;
    if (tString != null) data[CodeType._string] = tString;
    if (tByte != null) data[CodeType._byte] = tByte;
    if (tShort != null) data[CodeType._short] = tShort;
    if (tInteger != null) data[CodeType._integer] = tInteger;
    if (tLong != null) data[CodeType._long] = tLong;
    if (tFloat != null) data[CodeType._float] = tFloat;
    if (tDouble != null) data[CodeType._double] = tDouble;
    if (others != null) data.addAll(others);

    return CodeTypeNameMapperConfig(child, data);
  }

  @override
  Node build(BuildContext context) {
    final parent =
        context.findAncestorNodeOfExactType<CodeTypeNameMapperConfig>();
    if (parent != null && parent.map != null) {
      // Merges parent settings
      for (final i in parent.map.entries) {
        map.putIfAbsent(StringFuncs.camel(i.key), () => i.value);
      }
    }

    return super.build(context);
  }

  String translate(String name) {
    final key = StringFuncs.camel(name);
    return map.containsKey(key) ? map[key] : null;
  }
}

class CodeTypeNameConfig extends CodeConfigNode<CodeTypeName> {
  CodeTypeNameConfig(NodeBuildFunc<CodeTypeName> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeTypeNameConfig.forJavaLike(Node child) =>
      CodeTypeNameConfig((context, name) {
        return _doMap(context, name.name, StringFuncs.pascal);
      }, child);

  factory CodeTypeNameConfig.forDartLike(Node child) =>
      CodeTypeNameConfig((context, name) {
        var res = _doMap(context, name.name, StringFuncs.pascal);
        if (name.isPrivate == true) {
          // Add '_' prefix for non public field.
          res = Pad.left('_', res, onlyIfMissing: true);
        }
        return res;
      }, child);

  static Node _doMap(BuildContext context, Node name, StringFunc func) {
    final mapperConfig =
        context.findAncestorNodeOfExactType<CodeTypeNameMapperConfig>();

    return TextTransform(name, (s) {
      return mapperConfig?.translate(s) ?? func(s);
    });
  }
}

class CodeTypeName extends CodeConfigProxyNode<CodeTypeName>
    implements _NamedNode {
  @override
  final Node name;

  final bool isPrivate;

  CodeTypeName._(this.name, this.isPrivate) : assert(name != null);

  factory CodeTypeName.of(dynamic name, {bool isPrivate}) {
    name = _parseNameNode(name);
    if (name == null) return null;

    return CodeTypeName._(name, isPrivate);
  }
}
