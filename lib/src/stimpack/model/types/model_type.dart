part of g3.stimpack.model;

/// The pre-defined set of types, commonly used for modeling.
class StimModelTypes {
  StimModelType tag,
      name,
      nameSet,
      funcCode,
      funcCodeSet,
      tagSet,
      type,
      typeSet,
      package,
      packageSet,
      field,
      fieldSet,
      filter,
      filterSet,
      pattern,
      patternSet,
      range,
      rangeSet,
      typeRule,
      typeRuleSet,
      fieldRule,
      fieldRuleSet,
      error,
      errorSet,
      httpStatus,
      httpStatusSet,
      grpcStatus,
      grpcStatusSet;
}

// Reusable type mirror fo StimSymbol type.
TypeMirror _stimSymbolType;

// Pattern to split type name string to a bag of words.
RegExp _splitTypeNameRegEx = RegExp('[A-Z][^A-Z]*');

class StimModelTypeScope {
  StimModelType string,
      num,
      int,
      double,
      bool,
      duration,
      uri,
      dateTime,
      type,
      field,
      map,
      list,
      set;

  Set<StimModelType> primitiveTypes;
  Set<StimModelType> numberTypes;
  Set<StimModelType> collectionTypes;

  /// Provides meta information for the model package.
  StimModelTypes model;

  /// The internal map of dart types created via the scope.
  Map<TypeMirror, StimModelType> _dartTypes;

  StimModelType of({
    @meta.required dynamic name,
    @meta.required StimModelPackage package,
    Set<StimModelType> interfaces,
    Set<StimModelField> fields,
    Set<StimModelTypeRule> rules,
    Set<StimModelFilter> filters,
    String comment,
    Set<StimModelTag> tags,
  }) {
    final res = StimModelType()
      ..name = StimName.of(name)
      ..package = package
      ..interfaces = interfaces ?? {}
      ..fields = fields ?? {}
      ..filters = filters ?? {}
      ..comment = comment
      ..rules = rules ?? {}
      ..tags = tags;

    // Adds the type to the package if that is specified.
    package?.types += res;
    return res;
  }

  StimModelType primitiveOf({
    dynamic name,
    @meta.required StimModelPackage package,
    String comment,
    Set<StimModelTag> tags,
  }) {
    return of(
      name: name,
      package: package,
      fields: null,
      comment: comment,
      tags: tags,
    );
  }

  StimModelType fromDart(
    Type type, {
    Set<StimModelFilter> filters,
    String comment,
    Set<StimModelTag> tags,
  }) {
    _dartTypes ??= {};
    var stimType = _dartTypes[type];

    // Only creates one instance for a dart type.
    if (stimType != null) return stimType;

    final rt = reflectType(type);

    // Figure out the packages own this type.
    var library = rt.owner;
    while (library != null && library is! LibraryMirror) {
      library = library.owner;
    }

    assert(library != null, 'BUG. We need to be able to find the library');

    final package = stimpack.model.package.fromDart(library);
    var uri = package.dartLibrary.uri;
    var scheme = uri?.scheme;
    assert(
      scheme == 'package' || scheme == 'dart',
      'cannot import ${type} from "${scheme}" scheme, '
      'with uri: ${uri}',
    );

    final typeName = type.toString();

    // Handles the edge case where the type is actually the
    // dart version of a model type. In this case, we should not
    // create a new instance,and reuse the existing model type
    // instead. First check, if that has common prefix.
    if (typeName.startsWith('Stim')) {
      // Second potential match. The targeted type is a symbol.
      // Let's check the dart package to see if that does come
      // from the stimpack engine or not.
      _stimSymbolType ??= reflectType(StimSymbol);
      if (rt.isSubtypeOf(_stimSymbolType)) {
        final matches = _splitTypeNameRegEx.allMatches(typeName);
        if (matches.length > 2) {
          // now continue looking into it to see if the second part
          // is a pack.
          final m1 = matches.elementAt(1);
          final potentialPackName =
              typeName.substring(m1.start, m1.end).toLowerCase();

          // just get the remaining as a symbol
          final m2 = matches.elementAt(2);
          var potentialSymbolName = typeName.substring(m2.start);
          potentialSymbolName = potentialSymbolName[0].toLowerCase() +
              potentialSymbolName.substring(1);

          final s =
              'stimpack.model.type.${potentialPackName}.${potentialSymbolName}';

          assert(false, 'Please use $s instead of a dart type name.');
        }

        // now just use magic symbol to figure out if possible
      }
    }

    stimType ??= StimModelType()
      ..name = StimName.of(typeName)
      ..package = package
      ..dartType = rt
      ..filters = filters ?? {}
      ..comment = comment
      ..tags = tags ?? {};

    return _dartTypes[rt] = stimType;
  }

  StimModelType collectionOf({
    dynamic name,
    @meta.required StimModelPackage package,
    @meta.required Set<StimModelField> fields,
    @meta.required StimModelType collection,
    @meta.required StimModelType item,
    String comment,
    Set<StimModelTypeRule> rules,
    Set<StimModelTag> tags,
  }) {
    assert(collection != null, 'collection is required');
    assert(item != null, 'item is required');

    return of(
      name: name,
      package: package,
      fields: fields,
      comment: comment,
      rules: rules,
      tags: tags,
    )
      ..collection = collection
      ..item = item;
  }

  StimModelType listOf({
    dynamic name,
    @meta.required StimModelType item,
    String comment,
    Set<StimModelTypeRule> rules,
    Set<StimModelTag> tags,
  }) {
    assert(item != null, 'item is required');
    final list = stimpack.model.type.list;
    return collectionOf(
      name: name ?? list.name >> '<' >> item.name >> '>',
      package: list.package,
      fields: list.fields,
      collection: list,
      item: item,
      comment: comment,
      rules: rules,
      tags: tags,
    );
  }

  StimModelType setOf({
    dynamic name,
    @meta.required StimModelType item,
    String comment,
    Set<StimModelTypeRule> rules,
    Set<StimModelTag> tags,
  }) {
    final set = stimpack.model.type.set;
    return collectionOf(
      name: name ?? set.name >> '<' >> item.name >> '>',
      package: set.package,
      fields: set.fields,
      collection: set,
      item: item,
      comment: comment,
      rules: rules,
      tags: tags,
    );
  }
}

class StimModelType extends StimModelSymbol<StimModelType> {
  /// A model might belong to a package.
  StimModelPackage package;

  /// The sets of interfaces this model implements.
  Set<StimModelType> interfaces;

  /// The set of declared fields for this type.
  Set<StimModelField> fields;

  /// The set of rules applied to this type
  Set<StimModelTypeRule> rules;

  /// The set of filters can be applied to this type.
  Set<StimModelFilter> filters;

  /// This is only used for collection type.
  StimModelType collection;

  /// This is only used for collection type.
  StimModelType item;

  /// This field is only not null when the type is come from
  /// a dart type. In this case, the [package] should points
  /// to a [StimModelPackage] that is also from a dart library.
  TypeMirror dartType;

  String comment;

  /// True indicates that this is a collection type.
  bool get isCollection => collection != null;

  bool get isDartSet => collection == _model.type.set;

  bool get isDartList => collection == _model.type.list;

  /// Determines if this field is a dart number type, which could
  /// be int, double, ...
  bool get isDartNumber => _model.type.numberTypes.contains(this);

  /// Determines if this field is a dart string type.
  bool get isDartString => _model.type.string == this;

  /// Determines if this field is a dart bool type.
  bool get isDartBool => _model.type.bool == this;

  /// Determines if this field is a dart duration type.
  bool get isDartDuration => _model.type.duration == this;

  /// Determines if this field is a dart date time type.
  bool get isDartDateTime => _model.type.dateTime == this;

  /// True indicates that this type is from the dart type system.
  /// It is a not a user-defined type.
  bool get isDart => dartType != null;

  StimModelType();

  Set<StimModelChoice> get choices {
    if (rules?.isNotEmpty != true) return {};
    Set<StimModelChoice> res;

    for (final rule in rules) {
      final choices = rule.choices;
      if (choices?.isNotEmpty != true) continue;
      if (res == null) {
        res = choices;
      } else {
        res = res.intersection(choices);
      }
    }

    return res;
  }

  /// Gets the range applied to the field
  StimModelRange get range {
    if (rules?.isNotEmpty != true) return null;
    final processed = <StimModelRange>{};
    var min, max;

    for (final rule in rules) {
      final ranges = rule.ranges;
      if (ranges?.isNotEmpty != true) continue;
      for (final range in ranges) {
        if (processed.contains(range)) continue;
        processed.add(range);
        if (range.min != null && (min == null || range.min < min)) {
          // record new min
          min = range.min;
        }

        if (range.max != null && (max == null || range.max > max)) {
          // record new max
          max = range.max;
        }
      }
    }

    // combine the ranges to make the final result.
    if (processed.isEmpty) return null;

    return StimModelRange()
      ..name = StimName.of('$min-$max')
      ..min = min
      ..max = max;
  }

  StimModelType copyWith({
    dynamic name,
    StimModelPackage package,
    Set<StimModelType> interfaces,
    Set<StimModelField> fields,
    Set<StimModelTypeRule> rules,
    Set<StimModelFilter> filters,
    StimModelType collection,
    StimModelType item,
    TypeMirror dartType,
    String comment,
    Set<StimModelTag> tags,
  }) {
    return StimModelType()
      ..name = StimName.of(name ?? this.name)
      ..package = package ?? this.package
      ..interfaces = interfaces ?? this.interfaces
      ..fields = fields ?? this.fields
      ..rules = rules ?? this.rules
      ..filters = filters ?? this.filters
      ..collection = collection ?? this.collection
      ..item = item ?? this.item
      ..dartType = dartType ?? this.dartType
      ..comment = comment ?? this.comment
      ..tags = tags ?? this.tags;
  }
}
