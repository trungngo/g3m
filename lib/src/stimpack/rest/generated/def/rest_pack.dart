part of g3.stimpack.rest.generated;


/// The only instance of the [StimRest] pack.
StimRest _rest;



class StimRest extends StimPack {
  StimModelPackage _metaPackage;

  /// Scope class for constructing all "api" symbols, 
  /// typed of [StimRestApi]."
  final StimRestApiScope api;

  /// Scope class for constructing all "apiRequest" symbols, 
  /// typed of [StimRestApiRequest]."
  final StimRestApiRequestScope apiRequest;

  /// Scope class for constructing all "apiResponse" symbols, 
  /// typed of [StimRestApiResponse]."
  final StimRestApiResponseScope apiResponse;

  /// Scope class for constructing all "crudApi" symbols, 
  /// typed of [StimRestCrudApi]."
  final StimRestCrudApiScope crudApi;

  /// Scope class for constructing all "crudCreateOneApi" symbols, 
  /// typed of [StimRestCrudCreateOneApi]."
  final StimRestCrudCreateOneApiScope crudCreateOneApi;

  /// Scope class for constructing all "crudUpdateOneApi" symbols, 
  /// typed of [StimRestCrudUpdateOneApi]."
  final StimRestCrudUpdateOneApiScope crudUpdateOneApi;

  /// Scope class for constructing all "crudFindOneApi" symbols, 
  /// typed of [StimRestCrudFindOneApi]."
  final StimRestCrudFindOneApiScope crudFindOneApi;

  /// Scope class for constructing all "crudDeleteOneApi" symbols, 
  /// typed of [StimRestCrudDeleteOneApi]."
  final StimRestCrudDeleteOneApiScope crudDeleteOneApi;

  /// Scope class for constructing all "crudFindApi" symbols, 
  /// typed of [StimRestCrudFindApi]."
  final StimRestCrudFindApiScope crudFindApi;

  /// Scope class for constructing all "crudDeleteApi" symbols, 
  /// typed of [StimRestCrudDeleteApi]."
  final StimRestCrudDeleteApiScope crudDeleteApi;

  final OnStimModelTypeForRest onStimModelType;

  final OnStimRbacResourceForRest onStimRbacResource;

  StimRest(StimModel model, StimRbac rbac):
      api = StimRestApiScope(),
      apiRequest = StimRestApiRequestScope(),
      apiResponse = StimRestApiResponseScope(),
      crudApi = StimRestCrudApiScope(),
      crudCreateOneApi = StimRestCrudCreateOneApiScope(),
      crudUpdateOneApi = StimRestCrudUpdateOneApiScope(),
      crudFindOneApi = StimRestCrudFindOneApiScope(),
      crudDeleteOneApi = StimRestCrudDeleteOneApiScope(),
      crudFindApi = StimRestCrudFindApiScope(),
      crudDeleteApi = StimRestCrudDeleteApiScope(),
      onStimModelType = OnStimModelTypeForRest(),
      onStimRbacResource = OnStimRbacResourceForRest(),
      super('rest');


  /// Provides global access to the "rest" pack. Only one instance of the pack 
  /// is created. During the creation, other packs that this pack depends on might 
  /// be created as well.
  static StimRest stimRestInstance() {
    if (_rest == null) {
      _rest = StimRest(stimpack.model, stimpack.rbac);
      _rest._init();
    }
    return _rest;
  }

  void _init() {
    // Builds the meta definition that defines the structure of this pack.
    _buildMeta();
  }

  void _buildMeta() {
    final m = stimpack.model, f = m.field, t = m.type;
    final mp = _metaPackage = m.package.of(name: 'rest');
    final mt = onStimModelType;
    // Builds type "api"
    mt.api = t.symbolOf(name: 'api', package: mp);

    // Builds type "apiRequest"
    mt.apiRequest = t.symbolOf(name: 'apiRequest', package: mp);

    // Builds type "apiResponse"
    mt.apiResponse = t.symbolOf(name: 'apiResponse', package: mp);

    // Builds type "crudApi"
    mt.crudApi = t.symbolOf(name: 'crudApi', package: mp);

    // Builds type "crudCreateOneApi"
    mt.crudCreateOneApi = t.symbolOf(name: 'crudCreateOneApi', package: mp);

    // Builds type "crudUpdateOneApi"
    mt.crudUpdateOneApi = t.symbolOf(name: 'crudUpdateOneApi', package: mp);

    // Builds type "crudFindOneApi"
    mt.crudFindOneApi = t.symbolOf(name: 'crudFindOneApi', package: mp);

    // Builds type "crudDeleteOneApi"
    mt.crudDeleteOneApi = t.symbolOf(name: 'crudDeleteOneApi', package: mp);

    // Builds type "crudFindApi"
    mt.crudFindApi = t.symbolOf(name: 'crudFindApi', package: mp);

    // Builds type "crudDeleteApi"
    mt.crudDeleteApi = t.symbolOf(name: 'crudDeleteApi', package: mp);

    // Builds fields for type "api"
    mt.api.fields = {
      // field "api"
      f.of(name: 'policy', type: t.rbac.policy),

      // field "api"
      f.of(name: 'request', type: mt.apiRequest)..required(),

      // field "api"
      f.of(name: 'response', type: mt.apiResponse)..required(),

      // field "api"
      f.of(name: 'comment', type: t.fromDart(String))
    };

    // Builds fields for type "apiRequest"
    mt.apiRequest.fields = {
      // field "apiRequest"
      f.of(name: 'streamed', type: t.fromDart(bool)),

      // field "apiRequest"
      f.of(name: 'model', type: t.model.type)..required(),

      // field "apiRequest"
      f.of(name: 'comment', type: t.fromDart(String))
    };

    // Builds fields for type "apiResponse"
    mt.apiResponse.fields = {
      // field "apiResponse"
      f.of(name: 'streamed', type: t.fromDart(bool)),

      // field "apiResponse"
      f.of(name: 'model', type: t.model.type)..required(),

      // field "apiResponse"
      f.of(name: 'comment', type: t.fromDart(String))
    };

    // Builds fields for type "crudApi"
    mt.crudApi.fields = {
      // field "crudApi"
      f.of(name: 'model', type: t.model.type)..required(),

      // field "crudApi"
      f.of(name: 'id field', type: t.model.field)..required(),

      // field "crudApi"
      f.of(name: 'create one', type: mt.crudCreateOneApi),

      // field "crudApi"
      f.of(name: 'update one', type: mt.crudUpdateOneApi),

      // field "crudApi"
      f.of(name: 'find one', type: mt.crudFindOneApi),

      // field "crudApi"
      f.of(name: 'delete one', type: mt.crudDeleteOneApi),

      // field "crudApi"
      f.of(name: 'find', type: mt.crudFindApi),

      // field "crudApi"
      f.of(name: 'delete', type: mt.crudDeleteApi)
    };

    // Builds fields for type "crudCreateOneApi"
    mt.crudCreateOneApi.fields = {
      // field "crudCreateOneApi"
      f.of(name: 'id field', type: t.model.field),

      // field "crudCreateOneApi"
      f.of(name: 'api', type: mt.api)..required(),

      // field "crudCreateOneApi"
      f.of(name: 'comment', type: t.fromDart(String))
    };

    // Builds fields for type "crudUpdateOneApi"
    mt.crudUpdateOneApi.fields = {
      // field "crudUpdateOneApi"
      f.of(name: 'id field', type: t.model.field),

      // field "crudUpdateOneApi"
      f.of(name: 'api', type: mt.api)..required(),

      // field "crudUpdateOneApi"
      f.of(name: 'comment', type: t.fromDart(String))
    };

    // Builds fields for type "crudFindOneApi"
    mt.crudFindOneApi.fields = {
      // field "crudFindOneApi"
      f.of(name: 'id field', type: t.model.field),

      // field "crudFindOneApi"
      f.of(name: 'api', type: mt.api)..required(),

      // field "crudFindOneApi"
      f.of(name: 'comment', type: t.fromDart(String))
    };

    // Builds fields for type "crudDeleteOneApi"
    mt.crudDeleteOneApi.fields = {
      // field "crudDeleteOneApi"
      f.of(name: 'id field', type: t.model.field),

      // field "crudDeleteOneApi"
      f.of(name: 'api', type: mt.api)..required(),

      // field "crudDeleteOneApi"
      f.of(name: 'comment', type: t.fromDart(String))
    };

    // Builds fields for type "crudFindApi"
    mt.crudFindApi.fields = {
      // field "crudFindApi"
      f.of(name: 'api', type: mt.api)..required(),

      // field "crudFindApi"
      f.of(name: 'comment', type: t.fromDart(String))
    };

    // Builds fields for type "crudDeleteApi"
    mt.crudDeleteApi.fields = {
      // field "crudDeleteApi"
      f.of(name: 'api', type: mt.api)..required(),

      // field "crudDeleteApi"
      f.of(name: 'comment', type: t.fromDart(String))
    };
  }
}
