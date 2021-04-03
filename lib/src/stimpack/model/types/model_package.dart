part of g3.stimpack.model;

class StimModelPackageScope {
  StimModelPackage model;

  Map<DeclarationMirror, StimModelPackage> _dartPackages;

  StimModelPackage of({
    @meta.required dynamic name,
    StimModelPackage parent,
    Set<StimModelTag> tags,
  }) {
    return StimModelPackage()
      ..name = StimName.of(name)
      ..parent = parent
      ..types = {}
      ..tags = tags ?? {};
  }

  /// Creates a new package from a dart library.
  /// This implementation shall make sure only 1 instance of
  /// [StimModelPackage] is created for a [library].
  StimModelPackage fromDart(LibraryMirror library) {
    _dartPackages ??= {};
    var package = _dartPackages[library];

    // Only creates one instance of a dart package.
    if (package != null) return package;
    _dartPackages[library] = package = StimModelPackage()
      ..name = StimName.of(library.qualifiedName)
      ..dartLibrary = library;

    return package;
  }
}

class StimModelPackage extends StimModelSymbol<StimModelPackage> {
  /// The parent package of the current package.
  StimModelPackage parent;

  /// The set of types in this package.
  Set<StimModelType> types;

  /// This instance is only not null when the library come
  /// from a dart library.
  LibraryMirror dartLibrary;

  /// Determines if the current package come from dart.
  bool get isDart => dartLibrary != null;

  StimModelPackage();

  /// Gets out the ancestors, nearest first.
  Iterable<StimModelPackage> get ancestors sync* {
    var p = parent;
    while (p != null) {
      yield p;
      p = p.parent;
    }
  }

  String pathOf(String separator) {
    final packages = ancestors.toList().reversed.toList();
    packages.add(this);

    return packages.map((p) => p.name).toList().join(separator);
  }

  StimModelPackage copyWith({
    dynamic name,
    StimModelPackage parent,
    Set<StimModelType> types,
    LibraryMirror dartLibrary,
    Set<StimModelTag> tags,
  }) {
    return StimModelPackage()
      ..name = StimName.of(name ?? this.name)
      ..parent = parent ?? this.parent
      ..types = types ?? this.types
      ..dartLibrary = dartLibrary ?? this.dartLibrary
      ..tags = tags ?? this.tags;
  }
}
