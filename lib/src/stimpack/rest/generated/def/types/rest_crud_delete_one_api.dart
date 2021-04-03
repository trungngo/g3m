part of g3.stimpack.rest.generated;



class StimRestCrudDeleteOneApi extends StimModelSymbol<StimRestCrudDeleteOneApi> {
  StimModelField idField;

  StimRestApi api;

  String comment;

  StimRestCrudDeleteOneApi();


  /// Creates a new "crudDeleteOneApi" of [StimRestCrudDeleteOneApi] type.
  StimRestCrudDeleteOneApi copyWith(
    {@required dynamic name,
    StimModelField idField,
    @required StimRestApi api,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestCrudDeleteOneApi()
        ..name = StimName.of(name ?? this.name)
        ..idField = idField ?? this.idField
        ..api = api ?? this.api
        ..comment = comment ?? this.comment
        ..tags = tags ?? this.tags;
  }
}


class StimRestCrudDeleteOneApiScope {
  /// Creates a new "crudDeleteOneApi" of [StimRestCrudDeleteOneApi] type.
  StimRestCrudDeleteOneApi of(
    {@required dynamic name,
    StimModelField idField,
    @required StimRestApi api,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestCrudDeleteOneApi()
        ..name = StimName.of(name)
        ..idField = idField
        ..api = api
        ..comment = comment
        ..tags = tags ?? {};
  }
}
