part of g3.stimpack.rest.generated;



class OnStimModelTypeForRest {
  StimModelType api;

  StimModelType apiRequest;

  StimModelType apiResponse;

  StimModelType crudApi;

  StimModelType crudCreateOneApi;

  StimModelType crudUpdateOneApi;

  StimModelType crudFindOneApi;

  StimModelType crudDeleteOneApi;

  StimModelType crudFindApi;

  StimModelType crudDeleteApi;
}


class OnStimRbacResourceForRest {
  StimRbacResource restApi;
}



extension OnStimModelTypeForRestExtension on StimModelTypeScope {
  OnStimModelTypeForRest get rest {
    // Gets the type meta through stimpack public instance to trigger lazy init of the pack.
    return StimRest.stimRestInstance().onStimModelType;
  }
}


extension OnStimRbacResourceForRestExtension on StimRbacResourceScope {
  OnStimRbacResourceForRest get rest {
    // Gets the type meta through stimpack public instance to trigger lazy init of the pack.
    return StimRest.stimRestInstance().onStimRbacResource;
  }
}
