part of g3.stimpack.model;

class StimModelFields {
  StimModelField autoStringId;
  StimModelField stringId;
  StimModelField intId;
  StimModelField autoIntId;
  StimModelField fieldSet;
}

class StimModelFieldScope {
  /// The model fields.
  StimModelFields model;

  StimModelField of({
    @meta.required dynamic name,
    @meta.required StimModelType type,
    Set<StimModelFieldRule> rules,
    Set<StimModelFilter> filters,
    String comment,
    dynamic init,
    Set<StimModelTag> tags,
  }) {
    return StimModelField()
      ..name = StimName.of(name)
      ..type = type
      ..rules = rules
      ..filters = filters
      ..comment = comment
      ..init = init
      ..tags = tags;
  }

  StimModelField listOf({
    dynamic name,
    @meta.required StimModelType type,
    Set<StimModelFieldRule> rules,
    Set<StimModelFilter> filters,
    String comment,
    dynamic init,
    Set<StimModelTag> tags,
  }) {
    assert(type != null, 'type is required');
    return of(
      name: name,
      type: stimpack.model.type.listOf(item: type),
      rules: rules,
      filters: filters,
      comment: comment,
      tags: tags,
      init: init,
    );
  }

  StimModelField setOf({
    dynamic name,
    @meta.required StimModelType type,
    Set<StimModelFieldRule> rules,
    Set<StimModelFilter> filters,
    String comment,
    Set<StimModelTag> tags,
    dynamic init,
  }) {
    return of(
      name: name,
      type: stimpack.model.type.setOf(item: type),
      rules: rules,
      filters: filters,
      comment: comment,
      tags: tags,
      init: init,
    );
  }
}

class StimModelField extends StimModelSymbol<StimModelField> {
  // The data type that this field has.
  StimModelType type;

  /// The list of validation rules applied to this data field.
  Set<StimModelFieldRule> rules;

  /// The list of filters applied to this data field.
  /// Notes that [indexed] function shall add predefined set of
  /// filters to the field, given the field type.
  Set<StimModelFilter> filters;

  String comment;

  dynamic init;

  /// Determines if the field is required or not.
  bool get isRequired =>
      rules?.contains(stimpack.model.fieldRule.required) == true;

  /// Determines if the field is readonly or not.
  bool get isReadOnly =>
      rules?.contains(stimpack.model.fieldRule.readOnly) == true;

  /// Determines if the field is write only or not.
  bool get isWriteOnly =>
      rules?.contains(stimpack.model.fieldRule.writeOnly) == true;

  /// Determines if the field is modifiable after being created or not.
  bool get isCreateOnly =>
      rules?.contains(stimpack.model.fieldRule.createOnly) == true;

  /// Determines if the field is update only or not.
  bool get isUpdateOnly =>
      rules?.contains(stimpack.model.fieldRule.updateOnly) == true;

  /// Determines if the field is system only or not.
  bool get isSystemOnly =>
      rules?.contains(stimpack.model.fieldRule.systemOnly) == true;

  /// Determines if the field is transient or not.
  bool get isTransient =>
      rules?.contains(stimpack.model.fieldRule.transient) == true;

  /// Determines if the field is auto increased.
  bool get isAutoIncreased =>
      rules?.contains(stimpack.model.fieldRule.autoIncreased) == true;

  /// Determines if a field is unique or not.
  bool get isUnique => rules?.contains(stimpack.model.fieldRule.unique) == true;

  /// Determines if a field is indexed or not.
  bool get isIndexed =>
      rules?.contains(stimpack.model.fieldRule.indexed) == true;

  /// Marks that a field is required.
  void required() => rules += stimpack.model.fieldRule.required;

  /// Marks that a field should be indexed so that database queries can
  /// be applied to the field.
  void indexed() => rules += _model.fieldRule.indexed;

  /// Marks that this is a restricted field. It should be a target
  /// for role based access checking.
  void authorized() => rules += stimpack.model.fieldRule.authorized;

  /// Marks that whenever a field is returned, it is readonly.
  /// in the case of apis development, this field should not
  /// be send in any request body. For instance, the id field
  /// is read only for update api.
  void readOnly() => rules += stimpack.model.fieldRule.readOnly;

  /// Marks that this field is a write only field. An example,
  /// a field password might a write only field.
  void writeOnly() => rules += stimpack.model.fieldRule.writeOnly;

  /// Marks that this field is not modifiable after being created.
  void createOnly() => rules += stimpack.model.fieldRule.createOnly;

  /// Marks that this field is only available during update.
  void updateOnly() => rules += stimpack.model.fieldRule.updateOnly;

  /// Marks that this field is a system field. It will not be readable
  /// by users or external systems
  void systemOnly() => rules += stimpack.model.fieldRule.systemOnly;

  /// Marks that the field is transient and should not be persisted
  void transient() => rules += stimpack.model.fieldRule.transient;

  // Marks a field should unique.
  void unique() => rules += stimpack.model.fieldRule.unique;

  // Marks a field should be auto increased.
  void autoIncreased() => rules += stimpack.model.fieldRule.autoIncreased;

  /// Gets the intersection of all rules' choices
  Set<StimModelChoice> get choices {
    if (rules?.isNotEmpty != true) return {};
    Set<StimModelChoice> res;

    // Apply the type's choices if that is available
    final typeChoices = type.choices;
    if (typeChoices?.isNotEmpty == true) res = typeChoices;

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

  /// Gets the intersection of all rules' patterns
  Set<StimModelPattern> get patterns {
    if (rules?.isNotEmpty != true) return {};
    Set<StimModelPattern> res;

    for (final rule in rules) {
      final patterns = rule.patterns;
      if (patterns?.isNotEmpty != true) continue;
      if (res == null) {
        res = patterns;
      } else {
        res = res.intersection(patterns);
      }
    }

    return res;
  }

  /// Gets the set of errors applied to this fields
  Set<StimModelError> get errors {
    if (rules?.isNotEmpty != true) return {};
    final res = <StimModelError>{};

    for (final rule in rules) {
      final error = rule.error;
      if (res.contains(error)) continue;
      res.add(error);
    }

    return res;
  }

  /// Gets the intersection of all rule's range applied to this field.
  StimModelRange get range {
    if (rules?.isNotEmpty != true) return null;
    final processed = <StimModelRange>{};
    var min, max;

    void process(StimModelRange range) {
      processed.add(range);
      if (range.min != null && (min == null || range.min > min)) {
        // record new min
        min = range.min;
      }

      if (range.max != null && (max == null || range.max < max)) {
        // record new max
        max = range.max;
      }
    }

    /// Apply the data range from the model type rule first.
    final typeRange = type?.range;
    if (typeRange != null) {
      process(typeRange);
    }

    /// Apply all ranges defined in the field rule.
    for (final rule in rules) {
      final ranges = rule.ranges;
      if (ranges?.isNotEmpty != true) continue;
      for (final range in ranges) {
        if (processed.contains(range)) continue;
        process(range);
      }
    }

    // combine the ranges to make the final result.
    if (processed.isEmpty) return null;

    return StimModelRange()
      ..name = StimName.of('$min-$max')
      ..min = min
      ..max = max;
  }

  StimModelField copyWith({
    dynamic name,
    StimModelType type,
    Set<StimModelFieldRule> rules,
    Set<StimModelFilter> filters,
    Set<StimModelTag> tags,
    String comment,
    dynamic init,
  }) {
    return StimModelField()
      ..name = StimName.of(name ?? this.name)
      ..type = type ?? this.type
      ..rules = rules ?? this.rules
      ..filters = filters ?? this.filters
      ..comment = comment ?? this.comment
      ..init = init ?? this.init
      ..tags = tags ?? this.tags;
  }
}
