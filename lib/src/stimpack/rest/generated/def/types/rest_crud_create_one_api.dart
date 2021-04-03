part of g3.stimpack.rest.generated;



class StimRestCrudCreateOneApi extends StimModelSymbol<StimRestCrudCreateOneApi> {
  StimModelField idField;

  StimRestApi api;

  String comment;

  StimRestCrudCreateOneApi();


  /// Creates a new "crudCreateOneApi" of [StimRestCrudCreateOneApi] type.
  StimRestCrudCreateOneApi copyWith(
    {@required dynamic name,
    StimModelField idField,
    @required StimRestApi api,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestCrudCreateOneApi()
        ..name = StimName.of(name ?? this.name)
        ..idField = idField ?? this.idField
        ..api = api ?? this.api
        ..comment = comment ?? this.comment
        ..tags = tags ?? this.tags;
  }
}


class StimRestCrudCreateOneApiScope {
  /// Creates a new "crudCreateOneApi" of [StimRestCrudCreateOneApi] type.
  StimRestCrudCreateOneApi of(
    {@required dynamic name,
    StimModelField idField,
    @required StimRestApi api,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestCrudCreateOneApi()
        ..name = StimName.of(name)
        ..idField = idField
        ..api = api
        ..comment = comment
        ..tags = tags ?? {};
  }
}
