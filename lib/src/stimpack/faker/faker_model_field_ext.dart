part of g3.stimpack.faker.init;

extension OnStimModelFieldFakerExtension on StimModelField {
  /// Gets the default faker for the field, which is either the
  /// registered [customFaker] for the field, or the default faker
  /// from the field type.
  StimFakerType get faker =>
      firstValueOfTag<StimFakerType>(_fakerTagName) ?? type?.faker;

  set faker(StimFakerType faker) {
    if (faker == null) {
      removeAllTags(_fakerTagName);
    } else {
      final fakerType = faker.type;
      assert(
      fakerType == null ||
          type.isCollection ||
          type.isDartList ||
          type.isDartSet ||
          type == fakerType,
      'invalid faker type. ${type?.name?.pascal()} vs.'
          '${fakerType?.name?.pascal()}');

      setTag(name: _fakerTagName, value: faker);
    }
  }
}
