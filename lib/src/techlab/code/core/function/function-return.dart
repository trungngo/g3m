part of g3.techlab;

class CodeFunctionReturnConfig extends CodeConfigNode<CodeFunctionReturn> {
  CodeFunctionReturnConfig(
      NodeBuildFunc<CodeFunctionReturn> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeFunctionReturnConfig.forDartLike(Node child) =>
      CodeFunctionReturnConfig((context, funcReturn) {
        final async = funcReturn.isAsync == true;
        final stream = funcReturn.isStream == true;
        if (async && stream) {
          return Container([funcReturn.type, ' async*']);
        } else if (async) {
          return Container([funcReturn.type, ' async']);
        } else if (stream) {
          return Container([funcReturn.type, ' sync*']);
        } else {
          return funcReturn.type;
        }
      }, child);

  factory CodeFunctionReturnConfig.forJavaLike(Node child) =>
      CodeFunctionReturnConfig((context, funcReturn) {
        return funcReturn.type;
      }, child);
}

class CodeFunctionReturn extends CodeConfigProxyNode<CodeFunctionReturn> {
  final CodeType type;
  final bool isAsync;
  final bool isStream;

  CodeFunctionReturn._({
    @required this.type,
    this.isAsync,
    this.isStream,
  }) : assert(type != null);

  /// Try parse a dynamic value to an argument object.
  static CodeFunctionReturn _parse(dynamic value, {NodeParseErrorFunc error}) {
    return parseNode<CodeFunctionReturn>(value, (v) {
      final list = _toDynamicNodeList(v);

      if (list?.isNotEmpty != true || list.length > 1) {
        return null;
      }

      // Try to parse the input as the name expression.
      final type = CodeType._parse(list[0], error: error);

      return CodeFunctionReturn._(type: type);
    }, error: error);
  }

  factory CodeFunctionReturn.of({
    @required dynamic type,
    bool isAsync,
    bool isStream,
  }) {
    return CodeFunctionReturn._(
      type: CodeType._parse(type, error: () {
        throw '$type is an invalid function return type';
      }),
      isAsync: isAsync,
      isStream: isStream,
    );
  }
}
