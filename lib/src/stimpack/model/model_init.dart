part of g3.stimpack.model;

class StimModel extends StimPack {
  final StimModelPackageScope package;
  final StimModelTagScope tag;
  final StimModelTypeScope type;
  final StimModelFieldScope field;
  final StimModelFilterScope filter;
  final StimModelFieldRuleScope fieldRule;
  final StimModelTypeRuleScope typeRule;
  final StimModelFuncScope func;
  final StimModelChoiceScope choice;
  final StimModelPatternScope pattern;
  final StimModelRangeScope range;
  final StimModelHttpStatusScope httpStatus;
  final StimModelGrpcStatusScope grpcStatus;

  StimModel()
      : package = StimModelPackageScope(),
        tag = StimModelTagScope(),
        type = StimModelTypeScope(),
        field = StimModelFieldScope(),
        filter = StimModelFilterScope(),
        fieldRule = StimModelFieldRuleScope(),
        typeRule = StimModelTypeRuleScope(),
        func = StimModelFuncScope(),
        choice = StimModelChoiceScope(),
        pattern = StimModelPatternScope(),
        range = StimModelRangeScope(),
        httpStatus = StimModelHttpStatusScope(),
        grpcStatus = StimModelGrpcStatusScope(),
        super('model');

  void init() {
    _httpStatuses();
    _grpcStatuses();
    _patterns();
    _ranges();
    _typeRules();
    _fieldRules();
    _filters();
    _packages();
    _primitiveTypes();
    _collectionTypes();
    _metaTypes();
    _fields();
  }

  // ===========================================================================
  // Http Status
  // ===========================================================================

  void _httpStatuses() {
    _build200x();
    _build300x();
    _build400x();
    _build500x();

    httpStatus.ok200 = _http('ok', 200);
  }

  void _build200x() {
    final s = httpStatus;
    s.x200 = {
      s.ok200 = _http('ok', 200),
      s.created201 = _http('created', 201),
      s.accepted202 = _http('accepted', 202),
      s.nonAuthoritativeInfo203 = _http('non authoritative info', 203),
      s.noContent204 = _http('no content', 204),
    };
  }

  void _build300x() {
    final s = httpStatus;
    s.x300 = {
      s.multipleChoices300 = _http('multiple choices', 300),
      s.movedPermanently301 = _http('moved permanently', 301),
      s.found302 = _http('found', 302),
      s.seeOther303 = _http('see other', 303),
      s.notModified304 = _http('not modified', 304),
      s.useProxy305 = _http('use proxy', 305),
      s.switchProxy306 = _http('switch proxy', 306),
      s.temporarilyRedirected307 = _http('temporarily redirected', 307),
      s.permanentRedirected308 = _http('permanentRedirected', 308),
    };
  }

  void _build400x() {
    final s = httpStatus;
    s.x400 = {
      s.badRequest400 = _http('bad request', 400),
      s.unauthorized401 = _http('unauthorized', 401),
      s.paymentRequired402 = _http('payment required', 402),
      s.forbidden403 = _http('forbidden', 403),
      s.notFound404 = _http('not found', 404),
      s.methodNotAllowed405 = _http('method not allowed', 405),
      s.notAcceptable406 = _http('not acceptable', 406),
      s.proxyAuthenticationRequired407 =
          _http('proxy authentication required', 407),
      s.requestTimeout408 = _http('request timeout', 408),
      s.conflict409 = _http('conflict', 409),
      s.gone410 = _http('gone', 410),
      s.lengthRequired411 = _http('length required', 411),
      s.preconditionFailed412 = _http('precondition failed', 412),
      s.payloadTooLarge413 = _http('payload too large', 413),
      s.uriTooLong414 = _http('uri too long', 414),
      s.unsupportedMediaType415 = _http('unsupported media type', 415),
      s.rangeNotSatisfiable416 = _http('range not satisfiable', 416),
      s.expectationFailed417 = _http('expectation failed', 417),
      s.tooManyRequest429 = _http('too many request', 429),
      s.clientCloseRequest499 = _http('client close request', 499),
    };
  }

  void _build500x() {
    final s = httpStatus;
    s.x500 = {
      s.internalServerError500 = _http('internal server error', 500),
      s.notImplemented501 = _http('not implemented', 501),
      s.badGateway502 = _http('bad gateway', 502),
      s.serviceUnavailable503 = _http('service unavailable', 503),
      s.gatewayTimeout504 = _http('gateway timeout', 504),
      s.httpVersionNotSupported505 = _http('httpVersionNotSupported', 505),
    };
  }

  StimModelHttpStatus _http(String name, int code) {
    return httpStatus.of(name: name, code: code);
  }

  // ===========================================================================
  // Grpc Status
  // ===========================================================================

  void _grpcStatuses() {
    final s = grpcStatus;
    s.ok0 = _grpc('ok', 0, httpStatus.ok200);
    s.cancelled1 = _grpc('cancelled', 1, httpStatus.clientCloseRequest499);
    s.unknown2 = _grpc('unknown', 2, httpStatus.internalServerError500);
    s.invalidArgument3 = _grpc('invalid argument', 3, httpStatus.badRequest400);
    s.deadlineExceeded4 =
        _grpc('deadline exceed', 4, httpStatus.gatewayTimeout504);
    s.notFound5 = _grpc('not found', 5, httpStatus.notFound404);
    s.alreadyExists6 = _grpc('already exists', 6, httpStatus.conflict409);
    s.permissionDenied7 =
        _grpc('permission denied', 7, httpStatus.forbidden403);
    s.resourceExhausted8 =
        _grpc('resource exhausted', 8, httpStatus.tooManyRequest429);
    s.failedPrecondition9 =
        _grpc('failed precondition', 9, httpStatus.badRequest400);
    s.aborted10 = _grpc('aborted', 10, httpStatus.conflict409);
    s.outOfRange11 = _grpc('out of range', 11, httpStatus.badRequest400);
    s.unimplemented12 = _grpc('unimplemented', 12, httpStatus.badRequest400);
    s.internal13 = _grpc('internal', 13, httpStatus.internalServerError500);
    s.unavailable14 =
        _grpc('unavailable', 14, httpStatus.serviceUnavailable503);
    s.dataLoss15 = _grpc('data loss', 15, httpStatus.internalServerError500);
    s.unauthenticated16 =
        _grpc('unauthenticated', 16, httpStatus.unauthorized401);
  }

  StimModelGrpcStatus _grpc(
      String name, int code, StimModelHttpStatus httpStatus) {
    return grpcStatus.of(name: name, code: code, httpStatus: httpStatus);
  }

  // ===========================================================================
  // Patterns
  // ===========================================================================

  void _patterns() {
    final p = pattern;
    p.id = p.of(name: 'id');
    p.uuidV4 = p.of(name: 'uuid v4');
    p.slug = p.of(name: 'slug');

    p.ipv4 = p.of(name: 'ipv4');
    p.ipv6 = p.of(name: 'ipv6');
    p.ip = p.of(name: 'ip');

    p.url = p.of(name: 'url');
    p.email = p.of(name: 'email');
    p.username = p.of(name: 'username');
    p.password = p.of(name: 'password');
    p.phone = p.of(name: 'phone');
    p.zipCode = p.of(name: 'zip code');

    // data type pattern
    p.string = p.of(name: 'string');
    p.num = p.of(name: 'num');
    p.int = p.of(name: 'int');
    p.double = p.of(name: 'double');
    p.bool = p.of(name: 'bool');
    p.duration = p.of(name: 'duration');
    p.uri = p.of(name: 'uri');
    p.date = p.of(name: 'date');
    p.dateTime = p.of(name: 'date time');
    p.time = p.of(name: 'time');
  }

  // ===========================================================================
  // Ranges
  // ===========================================================================
  void _ranges() {}

  // ===========================================================================
  // Rules
  // ===========================================================================

  void _typeRules() {}

  void _fieldRules() {
    fieldRule
      ..required = fieldRule.of(name: 'required')
      ..unique = fieldRule.of(name: 'unique')
      ..indexed = fieldRule.of(name: 'indexed')
      ..authorized = fieldRule.of(name: 'authorized')
      ..readOnly = fieldRule.of(name: 'read only')
      ..writeOnly = fieldRule.of(name: 'write only')
      ..createOnly = fieldRule.of(name: 'create only')
      ..updateOnly = fieldRule.of(name: 'update only')
      ..systemOnly = fieldRule.of(name: 'system only')
      ..autoIncreased = fieldRule.of(name: 'auto increased')
      ..transient = fieldRule.of(name: 'transient');

    // pattern based fields
    final p = pattern;
    fieldRule
      ..id = _patternRule(p.id)
      ..uuidV4 = _patternRule(p.uuidV4)
      ..slug = _patternRule(p.slug)
      ..ipv4 = _patternRule(p.ipv4)
      ..ipv6 = _patternRule(p.ipv6)
      ..ip = _patternRule(p.url)
      ..email = _patternRule(p.email)
      ..username = _patternRule(p.username)
      ..password = _patternRule(p.password)
      ..phone = _patternRule(p.phone)
      ..zipCode = _patternRule(p.zipCode);

    // pattern based - data type
    fieldRule
      ..string = _patternRule(p.string)
      ..num = _patternRule(p.num)
      ..bool = _patternRule(p.bool)
      ..duration = _patternRule(p.duration)
      ..uri = _patternRule(p.uri)
      ..date = _patternRule(p.date)
      ..dateTime = _patternRule(p.dateTime)
      ..time = _patternRule(p.time);
  }

  StimModelFieldRule _patternRule(StimModelPattern pattern) {
    return fieldRule.of(name: pattern.name, patterns: {pattern});
  }

  // ===========================================================================
  // Filters
  // ===========================================================================

  void _filters() {
    final f = filter;

    f.isNull = _filter('is null');
    f.isNotNull = _filter('is not null');
    f.isEmpty = _filter('is empty');
    f.isNotEmpty = _filter('is not empty');
    f.isIn = _filter('is in');
    f.isNotIn = _filter('is not in');
    f.isExact = _filter('is exact');
    f.isNotExact = _filter('is not exact');

    final common = {
      f.isNull,
      f.isNotNull,
      f.isIn,
      f.isNotIn,
    };

    f.stringFilters = {
      ...common,
      f.isEmpty,
      f.isNotEmpty,
      f.isExact,
      f.isNotExact,
      f.isCaseInsensitiveExact = _filter('i exact'),
      f.startsWith = _filter('starts with'),
      f.caseInsensitiveStartsWith = _filter('i starts with'),
      f.endsWith = _filter('ends with'),
      f.caseInsensitiveEndsWith = _filter('i ends with'),
      f.contains = _filter('contains'),
      f.caseInsensitiveContains = _filter('i contains'),
      f.isCaseInsensitiveExact = _filter('is i exact'),
      f.matchesRegex = _filter('i regex'),
    };

    f.rangeFilters = {
      ...common,
      f.greaterThan = _filter('gt'),
      f.greaterThanOrEqual = _filter('gte'),
      f.lessThan = _filter('lt'),
      f.lessThanOrEqual = _filter('lte'),
      f.isInRange = _filter('range'),
    };

    f.boolFilters = {
      ...common,
      f.isExact,
      f.isNotExact,
    };
    f.numberFilters = {
      ...common,
      f.isExact,
      f.isNotExact,
      ...f.rangeFilters,
    };

    f.collectionFilters = {
      ...common,
    };

    f.ago = _filter('ago');
    f.dateFilters = {
      ...common,
      ...f.rangeFilters,
      f.ago,
      f.isDate = _filter('date'),
      f.isYear = _filter('year'),
      f.isMonth = _filter('month'),
      f.isDay = _filter('day'),
      f.isWeek = _filter('week'),
      f.isWeekDay = _filter('week day'),
      f.isQuarter = _filter('quarter'),
    };

    f.timeFilters = {
      ...common,
      f.ago,
      f.isTime = _filter('time'),
      f.isHour = _filter('hour'),
      f.isMinute = _filter('minute'),
      f.isSecond = _filter('second'),
    };

    f.dateTimeFilters = f.dateFilters + f.timeFilters;
  }

  StimModelFilter _filter(String name) => filter.of(name: name);

  // ===========================================================================
  // Packages
  // ===========================================================================

  void _packages() {}

  // ===========================================================================
  // Types
  // ===========================================================================

  void _primitiveTypes() {
    final t = type, f = filter;
    t.primitiveTypes = {
      t.string = t.fromDart(String, filters: f.stringFilters),
      t.num = t.fromDart(num, filters: f.numberFilters),
      t.int = t.fromDart(int, filters: f.numberFilters),
      t.double = t.fromDart(double, filters: f.numberFilters),
      t.bool = t.fromDart(bool, filters: f.boolFilters),
      t.dateTime = t.fromDart(DateTime, filters: f.dateTimeFilters),
      t.duration = t.fromDart(Duration, filters: f.rangeFilters),
      t.uri = t.fromDart(Uri),
      t.type = t.fromDart(Type),
    };
    t.numberTypes = {t.num, t.int, t.double};
  }

  void _collectionTypes() {
    final t = type, f = filter;
    t.collectionTypes = {
      t.map = t.fromDart(Map, filters: f.collectionFilters)..name ^= 'map',
      t.list = t.fromDart(List, filters: f.collectionFilters)..name ^= 'list',
      t.set = t.fromDart(Set, filters: f.collectionFilters)..name ^= 'set',
    };
  }

  void _metaTypes() {
    package.model = package.of(name: 'model');

    final mt = type.model = StimModelTypes();
    // name
    mt.name = type.fromDart(StimName);
    mt.nameSet = type.setOf(name: 'name set', item: mt.name);

    // func
    mt.funcCode = type.fromDart(StimModelFuncCode);
    mt.funcCodeSet = type.setOf(name: 'func set', item: mt.funcCode);

    // tag
    mt.tag = _symbolOf('tag');
    mt.tagSet = _symbolSetOf(mt.tag);

    // package
    mt.package = _symbolOf('package');
    mt.typeSet = _symbolSetOf(mt.package);

    // type
    mt.type = _symbolOf('type');
    mt.typeSet = _symbolSetOf(mt.type);

    // field
    mt.field = _symbolOf('field');
    mt.fieldSet = _symbolSetOf(mt.field);

    // filter
    mt.filter = _symbolOf('filter');
    mt.filterSet = _symbolSetOf(mt.filter);

    // pattern
    mt.pattern = _symbolOf('pattern');
    mt.patternSet = _symbolSetOf(mt.pattern);

    // range
    mt.range = _symbolOf('range');
    mt.rangeSet = _symbolSetOf(mt.range);

    // rule
    mt.typeRule = _symbolOf('type rule');
    mt.typeRuleSet = _symbolSetOf(mt.typeRule);

    // rule
    mt.fieldRule = _symbolOf('field rule');
    mt.fieldRuleSet = _symbolSetOf(mt.fieldRule);

    // error
    mt.error = _symbolOf('error');
    mt.errorSet = _symbolSetOf(mt.error);

    // http status
    mt.httpStatus = _symbolOf('http status');
    mt.httpStatusSet = _symbolSetOf(mt.httpStatus);

    // grpc status
    mt.grpcStatus = _symbolOf('grpc status');
    mt.grpcStatusSet = _symbolSetOf(mt.grpcStatus);
  }

  void _fields() {
    final f = field, t = type;
    final mf = f.model = StimModelFields();

    // Sets of fields.
    mf.stringId = f.of(name: 'id', type: t.string)..createOnly();
    mf.autoStringId = f.of(name: 'id', type: t.string)
      ..createOnly()
      ..readOnly();
    mf.intId = f.of(name: 'fields', type: t.int)..createOnly();
    mf.autoIntId = f.of(name: 'fields', type: t.int)
      ..createOnly()
      ..readOnly();
    mf.fieldSet = f.of(name: 'fields', type: t.model.fieldSet);
  }

  StimModelType _symbolOf(String name) {
    return type.of(
        name: 'stim model $name', package: package.model, fields: null);
  }

  StimModelType _symbolSetOf(StimModelType item) {
    return type.collectionOf(
      name: item.name << 'set<' >> '>',
      package: package.model,
      fields: null,
      collection: type.set,
      item: item,
    );
  }
}
