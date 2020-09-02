part of g3.stimpack2.meta.techlab;

class StimpackCodeConfig extends ExactlyOneNode<StimpackCodeConfig> {
  StimpackCodeConfig(Node child) : super(child);

  String packFileNameOf(StimModelPackage pack) {
    var p = pack.name.snake();
    return '${p}';
  }

  String typeFileNameOf(
    StimModelPackage pack,
    StimModelType type,
  ) {
    final p = pack.name.snake();
    final t = type.name.snake().toString().removeIfStartsWith('stim_${p}_');
    return '${p}__${t}';
  }

  StimName initPackFileNameOf(StimModelPackage pack) {
    return (pack.name >> 'init').snake();
  }

  StimName initPackFunctionNameOf(StimModelPackage pack) {
    return ('stim init' >> pack.name >> 'pack').camel();
  }

  // ===========================================================================
  // Pack
  // ===========================================================================

  StimName packClassNameOf(StimModelPackage pack) {
    return ('stim' >> pack.name).pascal();
  }

  // ===========================================================================
  // Symbol
  // ===========================================================================

  /// Gets the abstract class name that inherits from [StimSymbol].
  /// For example if the [pack] is 'grpc' and the [type] is 'message' then
  /// the class name is 'StimGrpcMessage'.
  ///
  StimName symbolClassNameOf(StimModelPackage pack, StimModelType type) {
    return type.name.pascal();
  }

  StimName symbolRefClassNameOf(StimModelPackage pack, StimModelType type) {
    return (type.name >> 'ref').pascal();
  }

  // ===========================================================================
  // Scope
  // ===========================================================================

  /// Gets an abstract class name that inherits from [StimScope].
  /// For example if the [pack] is 'grpc' and the [type] is 'message' then
  /// the class name is 'StimGrpcMessageScope'.
  ///
  StimName scopeClassNameOf(StimModelPackage pack, StimModelType type) {
    return (type.name >> 'scope').pascal();
  }

  // ===========================================================================
  // Code
  // ===========================================================================

  String publicTypeScopeOf(StimModelPackage pack, StimModelType type) {
    final typePack = type?.package ?? pack;
    return 'stimpack.${typePack.name.camel()}.${type.name.camel()}';
  }

  String publicMetaTypeName(StimModelPackage pack, StimModelType type,
      {prefix = 'stimpack.model.type'}) {
    final typePack = type?.package ?? pack;
    final presetName = typePack.name.camel();
    return '${prefix}.${presetName}.${type.name.camel()}';
  }

  CodePackage codePackageLibraryOf(StimModelPackage pack, {bool isPart}) {
    final path = ['g3', 'stimpack2', pack.name];
    final name = 'generated';
    if (isPart == true) {
      return CodePackage.partOf(name, path: path);
    } else {
      return CodePackage.of(name, path: path);
    }
  }

  CodeImport codePackImportOf(StimModelPackage pack) {
    return CodeImport.of(
        path: 'package:g3m/stimpack_${pack.name.camel()}.dart');
  }

  @override
  Node buildOne(BuildContext context, Node child) {
    return DartCodeConfig(child);
  }
}