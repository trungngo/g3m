part of g3.stimpack.rest.init;

extension ExtStimRestCrudUpdateOneApiScope on StimRestCrudUpdateOneApiScope {
  /// TODO: Documentation
  StimRestCrudUpdateOneApi forModel({
    dynamic name,
    StimModelPackage package,
    StimModelField idField,
    @required StimModelType model,
    Set<StimModelTag> tags,
  }) {
    assert(model != null, 'model is required');

    package ??= model.package;

    // default the api name to the model name.
    name ??= StimName.of('update one');
    final requestName = name >> model.name >> 'request';
    final responseName = name >> model.name >> 'response';

    return forFieldSet(
      name: name,
      package: package,
      idField: idField,
      fields: model.fields,
      requestName: requestName,
      responseName: responseName,
      tags: tags,
    );
  }

  /// TODO: Documentation
  StimRestCrudUpdateOneApi forFieldSet({
    @required dynamic name,
    @required StimModelPackage package,
    StimModelField idField,
    @required Set<StimModelField> fields,
    dynamic requestName,
    dynamic responseName,
    Set<StimModelTag> tags,
  }) {
    assert(name != null, 'name is required');
    assert(package != null, 'package is required');
    assert(fields != null, 'model fields is required');

    idField = _extractRequiredIdField(idField, fields);

    // builds the request and response fields.
    final request = <StimModelField>{
      // the id field must be in the request.
      idField.copyWith()..indexed(),
    };

    final response = <StimModelField>{};

    for (final field in fields) {
      // Ignore certain fields
      if (field.isSystemOnly || field.isCreateOnly) {
        continue;
      }

      // notes: id field cannot be updated by default.
      if (field != idField && !field.isReadOnly) request.add(field);
      if (!field.isWriteOnly) response.add(field);
    }

    return of(
      name: name,
      api: stimpack.rest.api.forFieldSet(
        name: name,
        package: package,
        requestName: requestName,
        request: request,
        responseName: responseName,
        response: response,
      ),
      tags: tags,
      idField: idField,
    );
  }
}
