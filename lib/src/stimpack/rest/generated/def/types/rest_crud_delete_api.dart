part of g3.stimpack.rest.generated;



class StimRestCrudDeleteApi extends StimModelSymbol<StimRestCrudDeleteApi> {
  StimRestApi api;

  String comment;

  StimRestCrudDeleteApi();


  /// Creates a new "crudDeleteApi" of [StimRestCrudDeleteApi] type.
  StimRestCrudDeleteApi copyWith(
    {@required dynamic name,
    @required StimRestApi api,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestCrudDeleteApi()
        ..name = StimName.of(name ?? this.name)
        ..api = api ?? this.api
        ..comment = comment ?? this.comment
        ..tags = tags ?? this.tags;
  }
}


class StimRestCrudDeleteApiScope {
  /// Creates a new "crudDeleteApi" of [StimRestCrudDeleteApi] type.
  StimRestCrudDeleteApi of(
    {@required dynamic name,
    @required StimRestApi api,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestCrudDeleteApi()
        ..name = StimName.of(name)
        ..api = api
        ..comment = comment
        ..tags = tags ?? {};
  }
}
