part of g3m.tool.generated;



class Package extends Expr<Package> {
  final ToolWorld world;

  Package(this.world):
      super(world.package);

  String _desc;

  String get desc {
    return _desc;
  }

  set desc(String value) {
    _desc = value;
    for (var i in eval()) {
      i._desc = value;
    }
  }
  int _version;

  int get version {
    return _version;
  }

  set version(int value) {
    _version = value;
    for (var i in eval()) {
      i._version = value;
    }
  }
  String _package;

  String get package {
    return _package;
  }

  set package(String value) {
    _package = value;
    for (var i in eval()) {
      i._package = value;
    }
  }
  Author _author;

  Author get author {
    return _author;
  }

  set author(Author value) {
    _author = value;
    assert(value != null, 'value is required');
    for (var i in eval()) {
      i._author = value;
    }
  }
  // region custom code
  /// implement custom code here

  // endregion custom code
}


class PackageScope extends Scope<Package> {
  final ToolWorld world;

  PackageScope(this.world);


  @override
  Package make() {
    return Package(world)
        ..author = world.author.none;
  }

  Package call({String desc, int version, String package, Author author}) {
    return add(null)
        ..desc = desc
        ..version = version
        ..package = package
        ..author = author;
  }
}
