part of g3.stimpack.rest.init;

extension ExtStimRestCrudFindApiScope on StimRestCrudFindApiScope {
  /// TODO: Documentation
  StimRestCrudFindApi forModel({
    dynamic name,
    StimModelField idField,
    StimModelPackage package,
    @required StimModelType model,
    Set<StimModelTag> tags,
  }) {
    assert(model != null, 'model is required');
    package ??= model.package;

    // default the api name to the model name.
    name ??= StimName.of('find');
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
  StimRestCrudFindApi forFieldSet({
    @required dynamic name,
    @required StimModelPackage package,
    @required StimModelField idField,
    @required Set<StimModelField> fields,
    dynamic requestName,
    dynamic responseName,
    Set<StimModelTag> tags,
  }) {
    assert(name != null, 'name is required');
    assert(package != null, 'package is required');

    assert(fields != null, 'model fields is required');
    final _idField = _extractRequiredIdField(idField, fields);

    final request = <StimModelField>{};

    final response = <StimModelField>{};

    for (final field in fields) {
      // Ignore certain fields
      if (field.isSystemOnly) continue;

      if (field == _idField || field.isIndexed || field.isUnique) {
        // Just add the id field by default. It is weird if any technology
        // don't auto indexed that field.
        request.add(field);
      }

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
    );
  }
}
