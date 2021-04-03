part of g3.stimpack.rest.generated;



class StimRestCrudFindOneApi extends StimModelSymbol<StimRestCrudFindOneApi> {
  StimModelField idField;

  StimRestApi api;

  String comment;

  StimRestCrudFindOneApi();


  /// Creates a new "crudFindOneApi" of [StimRestCrudFindOneApi] type.
  StimRestCrudFindOneApi copyWith(
    {@required dynamic name,
    StimModelField idField,
    @required StimRestApi api,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestCrudFindOneApi()
        ..name = StimName.of(name ?? this.name)
        ..idField = idField ?? this.idField
        ..api = api ?? this.api
        ..comment = comment ?? this.comment
        ..tags = tags ?? this.tags;
  }
}


class StimRestCrudFindOneApiScope {
  /// Creates a new "crudFindOneApi" of [StimRestCrudFindOneApi] type.
  StimRestCrudFindOneApi of(
    {@required dynamic name,
    StimModelField idField,
    @required StimRestApi api,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestCrudFindOneApi()
        ..name = StimName.of(name)
        ..idField = idField
        ..api = api
        ..comment = comment
        ..tags = tags ?? {};
  }
}
