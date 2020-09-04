part of g3.stimpack.model;

class StimModelFieldScope {
  StimModelField length;

  StimModelField of({
    @meta.required dynamic name,
    Set<StimModelTag> tags,
    @meta.required StimModelType type,
    Set<StimModelFieldRule> rules,
  }) {
    return StimModelField()
      ..name = StimName.of(name)
      ..tags = tags
      ..type = type
      ..rules = rules;
  }

  StimModelField listOf({
    dynamic name,
    Set<StimModelTag> tags,
    @meta.required StimModelType type,
    Set<StimModelFieldRule> rules,
  }) {
    return of(
      name: name,
      tags: tags,
      type: stimpack.model.type.listOf(item: type),
      rules: rules,
    );
  }

  StimModelField setOf({
    dynamic name,
    Set<StimModelTag> tags,
    @meta.required StimModelType type,
    Set<StimModelFieldRule> rules,
  }) {
    return of(
      name: name,
      tags: tags,
      type: stimpack.model.type.setOf(item: type),
      rules: rules,
    );
  }
}

class StimModelField extends StimModelSymbol<StimModelField> {
  // The data type that this field has.
  StimModelType type;

  /// The list of validation rules applied to this data field.
  Set<StimModelFieldRule> rules;

  bool get isRequired => rules?.contains(stimpack.model.rule.required) == true;

  bool get isUnique => rules?.contains(stimpack.model.rule.unique) == true;

  bool get isReadOnly => rules?.contains(stimpack.model.rule.readOnly) == true;

  bool get isWriteOnly =>
      rules?.contains(stimpack.model.rule.writeOnly) == true;

  StimModelField required() => this..rules += stimpack.model.rule.required;

  StimModelField unique() => this..rules += stimpack.model.rule.unique;

  StimModelField writeOnly() => this..rules += stimpack.model.rule.writeOnly;

  StimModelField readOnly() => this..rules += stimpack.model.rule.readOnly;

  StimModelFieldRef _ref;

  /// Gets the reference to this model.
  StimModelField get ref => _ref ??= StimModelFieldRef()..symbol = this;

  StimModelField();
}

class StimModelFieldRef extends StimSymbolRef<StimModelField>
    implements StimModelField {}
