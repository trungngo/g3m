part of g3.stimpack.model;

class StimModelSymbol<T extends StimModelSymbol<T>> extends StimSymbol<T>
    implements StimNamed {
  /// All model symbol should have a name.
  @override
  StimName name;

  /// All things in the models should have tags.
  Set<StimModelTag> tags;

  StimModelSymbol();

  StimModelSymbol.of(this.name, {this.tags});

  /// Adds a new tag with the specified [name] and [value].
  StimModelTag addTag({
    @meta.required dynamic name,
    @meta.required dynamic value,
  }) {
    tags ??= {};
    final tag = stimpack.model.tag.of(name: name, value: value);
    tags.add(tag);
    return tag;
  }

  /// Removes all tags with the same [name] and add a new one with
  /// the specified [name] and [value].
  StimModelTag setTag({
    @meta.required dynamic name,
    @meta.required dynamic value,
  }) {
    tags = tags?.where((t) => t.name != name)?.toSet();
    final tag = stimpack.model.tag.of(name: name, value: value);
    tags += tag;
    return tag;
  }

  /// Removes a tag with the specified [name] and [value].
  void removeTag({
    @meta.required dynamic name,
    @meta.required dynamic value,
  }) {
    assert(name != null, 'name is required');
    tags = tags?.where((t) => t.name != name || t.value != value)?.toSet();
  }

  E firstValueOfTagWithValueType<E>() {
    final value = tags?.firstWhereValueTypeIs<E>()?.value;
    return value == null ? null : value as E;
  }

  /// Gets the first tag with the specified [name].
  E firstValueOfTag<E>(dynamic name) {
    assert(name != null, 'name is required');
    final value = tags?.firstWhereNameIs(name)?.value;
    return value == null ? null : value as E;
  }

  /// Gets all tags with the specified [name].
  Iterable<E> allValuesOfTag<E>(dynamic name) {
    assert(name != null, 'name is required');
    return tags
        ?.whereNameIs(name)
        ?.map((e) => e.value == null ? null : e.value as E);
  }

  /// Removes all tags with the specified [name].
  void removeAllTags(dynamic name) {
    assert(name != null, 'name is required');
    tags = tags?.where((t) => t.name != name)?.toSet();
  }
}
