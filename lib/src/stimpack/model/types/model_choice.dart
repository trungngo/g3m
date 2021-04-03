part of g3.stimpack.model;

class StimModelChoiceScope {
  StimModelChoice named(
    dynamic name, {
    String comment,
    Set<StimModelTag> tags,
  }) {
    return of(name: name, value: name, comment: comment, tags: tags);
  }

  StimModelChoice of({
    @meta.required dynamic name,
    dynamic value,
    String comment,
    Set<StimModelTag> tags,
  }) {
    name = StimName.of(name);
    value = StimName.of(value);

    return StimModelChoice()
      ..name = name
      ..value = value
      ..comment = comment
      ..tags = tags;
  }
}

class StimModelChoice extends StimModelSymbol<StimModelChoice> {
  StimName value;

  String comment;

  StimModelChoice();

  StimModelChoice copyWith({
    dynamic name,
    dynamic value,
    String comment,
    Set<StimModelTag> tags,
  }) {
    return StimModelChoice()
      ..name = StimName.of(name ?? this.name)
      ..value = StimName.of(value ?? this.value)
      ..comment = comment ?? this.comment
      ..tags = tags ?? this.tags;
  }
}
