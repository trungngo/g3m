part of g3.stimpack.rest.generated;



class StimRestApiResponse extends StimModelSymbol<StimRestApiResponse> {
  bool streamed;

  StimModelType model;

  String comment;

  StimRestApiResponse();


  /// Creates a new "apiResponse" of [StimRestApiResponse] type.
  StimRestApiResponse copyWith(
    {@required dynamic name,
    bool streamed,
    @required StimModelType model,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestApiResponse()
        ..name = StimName.of(name ?? this.name)
        ..streamed = streamed ?? this.streamed
        ..model = model ?? this.model
        ..comment = comment ?? this.comment
        ..tags = tags ?? this.tags;
  }
}


class StimRestApiResponseScope {
  /// Creates a new "apiResponse" of [StimRestApiResponse] type.
  StimRestApiResponse of(
    {@required dynamic name,
    bool streamed,
    @required StimModelType model,
    String comment,
    Set<StimModelTag> tags}) {
    return StimRestApiResponse()
        ..name = StimName.of(name)
        ..streamed = streamed
        ..model = model
        ..comment = comment
        ..tags = tags ?? {};
  }
}
