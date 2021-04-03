part of g3.stimpack.rest.generated;



class StimRestCrudFindApi extends StimModelSymbol<StimRestCrudFindApi> {
  StimRestApi api;

  String comment;

  StimRestCrudFindApi();


  /// Creates a new "crudFindApi" of [StimRestCrudFindApi] type.
  StimRestCrudFindApi copyWith(
    {@required dynamic name,
    @required StimRestApi api,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestCrudFindApi()
        ..name = StimName.of(name ?? this.name)
        ..api = api ?? this.api
        ..comment = comment ?? this.comment
        ..tags = tags ?? this.tags;
  }
}


class StimRestCrudFindApiScope {
  /// Creates a new "crudFindApi" of [StimRestCrudFindApi] type.
  StimRestCrudFindApi of(
    {@required dynamic name,
    @required StimRestApi api,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestCrudFindApi()
        ..name = StimName.of(name)
        ..api = api
        ..comment = comment
        ..tags = tags ?? {};
  }
}
