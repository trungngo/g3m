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
    name ??= 'update one';

    return forFieldSet(
      name: name,
      package: package,
      idField: idField,
      fields: model.fields,
      tags: tags,
    );
  }

  /// TODO: Documentation
  StimRestCrudUpdateOneApi forFieldSet({
    @required dynamic name,
    @required StimModelPackage package,
    StimModelField idField,
    @required Set<StimModelField> fields,
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
      if (field.isSystemOnly || field.isTransient) continue;

      // notes: id field cannot be updated by default.
      if (field != idField && !field.isReadOnly) request.add(field);
      if (!field.isWriteOnly) response.add(field);
    }

    return of(
      name: name,
      api: stimpack.rest.api.forFieldSet(
        name: name,
        package: package,
        request: request,
        response: response,
      ),
      tags: tags,
      idField: idField,
    );
  }
}