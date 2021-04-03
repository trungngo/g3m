part of g3.stimpack.meta.techlab;

class StimGenMeta implements Node {
  /// The package that includes all types that we will need to generate code
  /// for. Each type shall have fields, and those fields refer to more
  /// types. Some of the referred types come from external stimpack
  /// packages, or come from dart type system. The code generation
  /// process shall need to import such dependencies.
  ///
  final StimModelPackage pack;

  /// The set of values to be defined for the current package and/or
  /// external stimpack packages. Values provides an easy way to
  /// refer to an instance of a type. For example, if we want
  /// to refer to an action defined in a story package, we can
  /// access [stimpack.story.action.manage], in which "story" is the story
  /// package, and "action" is a type defined in that package, and "manage"
  /// is a value defined for that type.
  ///
  final Map<StimModelType, Set<String>> values;

  StimpackCodeConfig _config;

  /// The external packs referred by this pack.
  /// This can be determined by figure out the types user by the other
  /// package.
  Set<StimModelPackage> _externalPacks;
  Map<StimModelType, Set<String>> _internalValues;
  Map<StimModelType, Set<String>> _externalValues;

  StimGenMeta(this.pack, this.values);

  @override
  Node build(BuildContext context) {
    _config = context.dependOnAncestorNodeOfExactType<StimpackCodeConfig>();

    // Travels through all referred types to figure out any external
    // packages we need to import into the generated libraries.
    _computeExternalPacks();

    // Values are a map of type -> values. We will need to loop through
    // the type list to figure out if any type coming from external
    // packages. These external packages shall need to be a required
    // field for the generated pack constructor so that it make sure
    // the external package is loaded before the current one.
    _splitToInternalAndExternalValues();

    return Container([
      Directory.relative(
        'generated',
        Container([
          StimGenMetaInitExt(pack),
          Directory.relative(
            'def',
            Container([
              StimGenMetaPack(pack, _externalPacks, _externalValues.keys),
              StimGenMetaLib(pack, _externalPacks),
              StimGenMetaExt(pack, _externalValues),
              Directory.relative(
                'types',
                _buildTypeFiles(),
              ),
            ]),
          ),
        ]),
      ),
      StimGenMetaInit(pack),
    ]);
  }

  /// This is breadth first search algorithm to go through all types
  /// referred by the current package to figure out the external package.
  void _computeExternalPacks() {
    final p = stimpack.model.package;

    final ignoredPackages = {p.model};

    /// Makes every pack depends on the model pack.
    _externalPacks = <StimModelPackage>{p.model};

    // This is the set of already processed types.
    // This is needed to make sure no type has been processed twice
    // to avoid recursive structure.
    final processed = <StimModelType>{};

    // This is the working queue, any newly discovered type should be
    // added to this queue. The algorithm shall need to pick up
    // on type at a time from this queue to process until the queue is empty.
    final queue = Queue.of(pack.types);

    while (queue.isNotEmpty) {
      // Dequeue a type to process.
      final t = queue.removeFirst();

      // Stop if that type is already processed.
      if (processed.contains(t)) continue;

      // Marks that the type is processed.
      processed.add(t);

      var tPackage = t.package;

      if (tPackage != pack && !ignoredPackages.contains(tPackage)) {
        _externalPacks.add(tPackage);
      }

      // Found more types to process.
      if (t.collection != null) queue.add(t.collection);
      if (t.item != null) queue.add(t.item);

      if (t.fields != null) {
        // Go into sub fields to find more types.
        for (final field in t.fields) {
          queue.add(field.type);
        }
      }
    }
  }

  void _splitToInternalAndExternalValues() {
    _internalValues = {};
    _externalValues = {};

    // Adds external values for type extension.
    // This is the special cases where all new types
    // defined in this package shall be injected
    // to the stimpack.model.type
    final typeNames = pack.types.map((type) {
      return _config.fieldNameOfType(type).toString();
    }).toSet();
    _externalValues[stimpack.model.type.model.type] = typeNames;

    if (values?.isNotEmpty != true) return;

    for (final e in values.entries) {
      final type = e.key;
      final values = e.value;
      if (values == null) continue;

      if (type.package == pack) {
        // this is an internal package.
        _internalValues[type] = values;
      } else {
        // this is an external package.
        final current = _externalValues[type];
        if (current == null) {
          _externalValues[type] = values;
        } else {
          _externalValues[type] += values;
        }

        // Adds the external pack to make sure it will
        // be loaded before this pack is loaded.
        _externalPacks.add(type.package);
      }
    }
  }

  Node _buildTypeFiles() {
    final files = pack.types.map((type) {
      final typeValues = values == null ? null : values[type];
      return StimGenMetaType(pack, type, typeValues);
    });

    return Container(files);
  }
}

void stimpackGen(
  StimModelPackage meta,
  String dir, {
  Map<StimModelType, Set<String>> values,
}) {
  stimpack.meta.validate(meta);

  Node program = PromptYesToAll(
    SingleChildNode(
      Directory.relative(
        dir,
        Directory.relative(
          meta.name.snake().toString(),
          StimpackCodeConfig(
            StimGenMeta(meta, values),
          ),
        ),
      ),
    ),
  );

  Program.execute(program);
}
