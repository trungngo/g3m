part of g3.stimpack.angular.generated;



class StimAngularApp extends StimModelSymbol<StimAngularApp> {
  StimIoDir featureDir;

  Set<StimAngularFeature> features;

  StimAngularApp();


  StimAngularApp ref() {
    return StimAngularAppRef()..symbol = this;
  }

  /// Creates a new "app" of [StimAngularApp] type.
  StimAngularApp refWith({dynamic name, StimIoDir featureDir, Set<StimAngularFeature> features, Set<StimModelTag> tags}) {
    final res = ref();
    if (name != null) {
      res.name = StimName.of(name);
    }
    if (featureDir != null) {
      res.featureDir = featureDir;
    }
    if (features != null) {
      res.features = features;
    }
    if (tags != null) {
      res.tags = tags;
    }
    return res;
  }
}


class StimAngularAppRef extends StimSymbolRef<StimAngularApp> implements StimAngularApp {

}


class StimAngularAppScope {
  /// Creates a new "app" of [StimAngularApp] type.
  StimAngularApp of({dynamic name, StimIoDir featureDir, Set<StimAngularFeature> features, Set<StimModelTag> tags}) {
    return StimAngularApp()
        ..name = StimName.of(name)
        ..featureDir = featureDir
        ..features = features ?? {}
        ..tags = tags ?? {};
  }
}
