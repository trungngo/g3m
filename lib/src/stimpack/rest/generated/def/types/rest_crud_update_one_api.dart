part of g3.stimpack.rest.generated;



class StimRestCrudUpdateOneApi extends StimModelSymbol<StimRestCrudUpdateOneApi> {
  StimModelField idField;

  StimRestApi api;

  String comment;

  StimRestCrudUpdateOneApi();


  /// Creates a new "crudUpdateOneApi" of [StimRestCrudUpdateOneApi] type.
  StimRestCrudUpdateOneApi copyWith(
    {@required dynamic name,
    StimModelField idField,
    @required StimRestApi api,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestCrudUpdateOneApi()
        ..name = StimName.of(name ?? this.name)
        ..idField = idField ?? this.idField
        ..api = api ?? this.api
        ..comment = comment ?? this.comment
        ..tags = tags ?? this.tags;
  }
}


class StimRestCrudUpdateOneApiScope {
  /// Creates a new "crudUpdateOneApi" of [StimRestCrudUpdateOneApi] type.
  StimRestCrudUpdateOneApi of(
    {@required dynamic name,
    StimModelField idField,
    @required StimRestApi api,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestCrudUpdateOneApi()
        ..name = StimName.of(name)
        ..idField = idField
        ..api = api
        ..comment = comment
        ..tags = tags ?? {};
  }
}
