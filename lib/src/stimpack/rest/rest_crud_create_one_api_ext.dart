part of g3.stimpack.rest.init;

extension ExtCrudCreateOneApiScope on StimRestCrudCreateOneApiScope {
  /// Givens a [model], this function shall help to create a "create one"
  /// crud api. The api's [name] can be specified. If that is missing, the
  /// framework shall use the [model] name to define the api. For instance,
  /// if the model name is "user", then the api name should be
  /// "create one user".
  ///
  /// The [model]'s field set shall be used to build the request and response
  /// models. Please refers to [forFieldSet] function to understand how
  /// that works.
  ///
  StimRestCrudCreateOneApi forModel({
    dynamic name,
    StimModelField idField,
    StimModelPackage package,
    @required StimModelType model,
    Set<StimModelTag> tags,
  }) {
    assert(model != null, 'model is required');
    package ??= model.package;

    // default the api name to the model name.
    name ??= 'create one';
    final requestName = name >> model.name >> 'request';
    final responseName = name >> model.name >> 'response';

    return forFieldSet(
      name: name,
      idField: idField,
      package: package,
      fields: model.fields,
      requestName: requestName,
      responseName: responseName,
      tags: tags,
    );
  }

  /// Givens a bag of [fields], this function shall help to create a
  /// create one crud api. The api's [name] must be specified. If
  /// the [idField] is passed in, that field shall be used as a way
  /// to uniquely identify the model record. Otherwise, the framework
  /// shall look for a field with the name `id` in the bag if specified
  /// [fields].
  ///
  /// A create one api would need a request and and response.
  /// The request & response should have strong typed name so that
  /// it can work with code generation. For instance, given a model
  /// 'user', then we should name the create one api as "create one user",
  /// and the request model as "create one user request", and the response
  /// is "create one user response".
  ///
  /// To compute the request fields, this function loops through the [fields]
  /// bag and extract all field that are not read only
  /// (e.g., computed fields by the backend), system only (e.g., timestamp,
  /// record version) / transient (e.g., fields that the caller just
  /// want as a inmemory computed fields). Notes that, if the idField is
  /// not marked as "read only", that framework shall allows api client to
  /// send in the id field.
  ///
  /// Similarly, to compute the response fields, this function loops through
  /// the [fields] bag and extract all the field that are not write only/system
  /// only/transition. Notes tha the [idField] should be in the response
  /// field unless the above condition does not met.
  ///
  StimRestCrudCreateOneApi forFieldSet({
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
    final request = <StimModelField>{};
    final response = <StimModelField>{
      // the id field must be in the response.
      idField,
    };

    for (final field in fields) {
      // Ignore certain fields
      if (field.isSystemOnly) continue;
      if (!field.isReadOnly && !field.isUpdateOnly) request.add(field);
      if (!field.isWriteOnly) response.add(field);
    }

    return of(
      name: name,
      tags: tags,
      idField: idField,
      api: _rest.api.forFieldSet(
        name: name,
        package: package,
        requestName: requestName,
        request: request,
        responseName: responseName,
        response: response,
      ),
    );
  }
}

StimModelField _extractRequiredIdField(
    StimModelField idField, Set<StimModelField> fields) {
  // find an id field if that is not specified.
  idField ??= fields.firstWhereNameIs('id');
  assert(fields.contains(idField),
      'either the id field is specified or the field set contains an id field');
  return idField;
}
