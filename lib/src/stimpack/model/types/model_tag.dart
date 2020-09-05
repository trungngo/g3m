part of g3.stimpack.model;

class StimModelTagScope {
  StimModelTag of({
    @meta.required dynamic name,
    @meta.required dynamic value,
    Iterable<StimModelTag> tags,
  }) =>
      StimModelTag()
        ..name = StimName.of(name)
        ..value = value
        ..tags = tags;
}

/// This provides the flexibility to attach any tags data to any model entity.
/// Tags are just key value pair and can be passed a long from one
/// transformation task to another.
///
class StimModelTag extends StimModelSymbol<StimModelTag> {
  /// Any value can be added to the tag.
  dynamic value;

  StimModelTag();

  /// Gets the reference to this model.
  StimModelTag ref() => StimModelTagRef()..symbol = this;

  StimModelTag refWith({
    dynamic name,
    dynamic value,
    Iterable<StimModelTag> tags,
  }) {
    final res = ref();
    if (name != null) res.name = StimName.of(name);
    if (value != null) res.value = value;
    if (tags != null) res.tags = tags;
    return res;
  }
}

class StimModelTagRef extends StimSymbolRef<StimModelTag>
    implements StimModelTag {}