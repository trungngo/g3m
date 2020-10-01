part of g3.stimpack.model;

StimModel _model;

extension OnStimPackModelExtension on StimpackRoot {
  StimModel get model {
    if (_model != null) return _model;
    _model ??= StimModel();
    _model.init();
    return _model;
  }
}

extension OnStimNameModelExtension<T extends StimNamed> on Set<T> {
  Set<T> whereNameIs(dynamic name) {
    name = StimName.of(name);
    return where((e) => e.name == name).toSet();
  }

  T firstWhereNameIs(dynamic name) {
    name = StimName.of(name);
    return firstWhere((e) => e.name == name, orElse: () => null);
  }

  void removeWhereNameIs(dynamic name) {
    name = StimName.of(name);
    removeWhere((e) => e.name == name);
  }
}

extension OnStimModelTagExtension<T extends StimModelTag> on Set<T> {
  Set<T> whereValueIs(dynamic value) {
    return where((e) => e.value == value).toSet();
  }

  T firstWhereValueIs(dynamic value) {
    return firstWhere((e) => e.value == value, orElse: () => null);
  }

  void removeWhereValueIs(dynamic value) {
    removeWhere((e) => e.value == value);
  }
}
