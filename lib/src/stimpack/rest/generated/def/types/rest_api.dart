part of g3.stimpack.rest.generated;



class StimRestApi extends StimModelSymbol<StimRestApi> {
  StimRbacPolicy policy;

  StimRestApiRequest request;

  StimRestApiResponse response;

  String comment;

  StimRestApi();


  /// Creates a new "api" of [StimRestApi] type.
  StimRestApi copyWith(
    {@required dynamic name,
    StimRbacPolicy policy,
    @required StimRestApiRequest request,
    @required StimRestApiResponse response,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestApi()
        ..name = StimName.of(name ?? this.name)
        ..policy = policy ?? this.policy
        ..request = request ?? this.request
        ..response = response ?? this.response
        ..comment = comment ?? this.comment
        ..tags = tags ?? this.tags;
  }
}


class StimRestApiScope {
  /// Creates a new "api" of [StimRestApi] type.
  StimRestApi of(
    {@required dynamic name,
    StimRbacPolicy policy,
    @required StimRestApiRequest request,
    @required StimRestApiResponse response,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestApi()
        ..name = StimName.of(name)
        ..policy = policy
        ..request = request
        ..response = response
        ..comment = comment
        ..tags = tags ?? {};
  }
}
