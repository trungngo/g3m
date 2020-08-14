part of g3.armory;

class CodeGenericParamConfig extends CodeConfigNode<CodeGenericParam> {
  CodeGenericParamConfig(NodeBuildFunc<CodeGenericParam> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodeGenericParamConfig.forJavaLike(Node child) =>
      CodeGenericParamConfig((context, param) {
        return param.name;
      }, child);
}

class CodeGenericParam extends CodeConfigProxyNode<CodeGenericParam> {
  final CodeType name;

  CodeGenericParam(this.name);

  factory CodeGenericParam.of(String name) =>
      CodeGenericParam(CodeType.simple(name));
}
