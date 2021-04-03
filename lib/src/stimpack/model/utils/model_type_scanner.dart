part of g3.stimpack.model;

/// Scans the list of given [types] to returns a map of packages vs.
/// types found from the specified types. The function shall look for all
/// related types found in the type's fields to compute the final map.
///
/// In the case that certain types or packages should be ignored during
/// the scan process, caller can implement the [isPackageIgnored] and
/// [isTypeIgnored] handlers.
///
Map<StimModelPackage, Set<StimModelType>> stimModelTypeScan({
  @meta.required Set<StimModelType> types,
  bool Function(StimModelPackage package) isPackageIgnored,
  bool Function(StimModelType type) isTypeIgnored,
}) {
  if (types?.isNotEmpty != true) return {};

  // This is the set of already processed types.
  // This is needed to make sure no type has been processed twice
  // to avoid recursive structure.
  final res = <StimModelPackage, Set<StimModelType>>{};
  final ignoredPackages = <StimModelPackage>{};
  final processed = <StimModelType>{};

  // This is the working queue, any newly discovered type should be
  // added to this queue. The algorithm shall need to pick up
  // on type at a time from this queue to process until the queue is empty.
  final queue = Queue.of(types);

  while (queue.isNotEmpty) {
    // Dequeue a type to process.
    final type = queue.removeFirst();
    if (processed.contains(type)) continue;
    // Marks that the type is processed.
    processed.add(type);

    // Stop if that type is already processed.
    final package = type.package;

    // Checks if the specified type is ignored or not.
    if (isTypeIgnored != null && isTypeIgnored(type)) continue;

    // Checks if the specified package is ignored or not.
    if (ignoredPackages.contains(package)) {
      continue;
    } else if (isPackageIgnored != null && isPackageIgnored(package)) {
      ignoredPackages.add(package);
      continue;
    }

    // The type is accepted.
    if (!type.isCollection) {
      var foundTypes = res[package];
      if (foundTypes == null) {
        res[package] = {type};
      } else {
        foundTypes.add(type);
      }
    }

    // Found more types to process.
    if (type.collection != null) queue.add(type.collection);
    if (type.item != null) queue.add(type.item);

    if (type.fields != null) {
      // Go into sub fields to find more types.
      for (final field in type.fields) {
        queue.add(field.type);
      }
    }
  }

  return res;
}

Map<StimModelPackage, Set<StimModelType>> stimMakePackageVsTypeMap({
  @meta.required Set<StimModelType> types,
  bool Function(StimModelPackage package) isPackageIgnored,
  bool Function(StimModelType type) isTypeIgnored,
}) {
  if (types?.isNotEmpty != true) return {};

  final res = <StimModelPackage, Set<StimModelType>>{};
  final ignoredPackages = <StimModelPackage>{};

  for (final type in types) {
    // Stop if that type is already processed.
    final package = type.package;

    // Checks if the specified type is ignored or not.
    if (isTypeIgnored != null && isTypeIgnored(type)) continue;

    // Checks if the specified package is ignored or not.
    if (ignoredPackages.contains(package)) {
      continue;
    } else if (isPackageIgnored != null && isPackageIgnored(package)) {
      ignoredPackages.add(package);
      continue;
    }

    // The type is accepted.
    if (!type.isCollection) {
      var foundTypes = res[package];
      if (foundTypes == null) {
        res[package] = {type};
      } else {
        foundTypes.add(type);
      }
    }
  }

  return res;
}
