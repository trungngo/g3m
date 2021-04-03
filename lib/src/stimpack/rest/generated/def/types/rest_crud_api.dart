part of g3.stimpack.rest.generated;



class StimRestCrudApi extends StimModelSymbol<StimRestCrudApi> {
  StimModelType model;

  StimModelField idField;

  StimRestCrudCreateOneApi createOne;

  StimRestCrudUpdateOneApi updateOne;

  StimRestCrudFindOneApi findOne;

  StimRestCrudDeleteOneApi deleteOne;

  StimRestCrudFindApi find;

  StimRestCrudDeleteApi delete;

  StimRestCrudApi();


  /// Creates a new "crudApi" of [StimRestCrudApi] type.
  StimRestCrudApi copyWith(
    {@required dynamic name,
    @required StimModelType model,
    @required StimModelField idField,
    StimRestCrudCreateOneApi createOne,
    StimRestCrudUpdateOneApi updateOne,
    StimRestCrudFindOneApi findOne,
    StimRestCrudDeleteOneApi deleteOne,
    StimRestCrudFindApi find,
    StimRestCrudDeleteApi delete,
    Set<StimModelTag> tags}) {
    return StimRestCrudApi()
        ..name = StimName.of(name ?? this.name)
        ..model = model ?? this.model
        ..idField = idField ?? this.idField
        ..createOne = createOne ?? this.createOne
        ..updateOne = updateOne ?? this.updateOne
        ..findOne = findOne ?? this.findOne
        ..deleteOne = deleteOne ?? this.deleteOne
        ..find = find ?? this.find
        ..delete = delete ?? this.delete
        ..tags = tags ?? this.tags;
  }
}


class StimRestCrudApiScope {
  /// Creates a new "crudApi" of [StimRestCrudApi] type.
  StimRestCrudApi of(
    {@required dynamic name,
    @required StimModelType model,
    @required StimModelField idField,
    StimRestCrudCreateOneApi createOne,
    StimRestCrudUpdateOneApi updateOne,
    StimRestCrudFindOneApi findOne,
    StimRestCrudDeleteOneApi deleteOne,
    StimRestCrudFindApi find,
    StimRestCrudDeleteApi delete,
    Set<StimModelTag> tags}) {
    return StimRestCrudApi()
        ..name = StimName.of(name)
        ..model = model
        ..idField = idField
        ..createOne = createOne
        ..updateOne = updateOne
        ..findOne = findOne
        ..deleteOne = deleteOne
        ..find = find
        ..delete = delete
        ..tags = tags ?? {};
  }
}
