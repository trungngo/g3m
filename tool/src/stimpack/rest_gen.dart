import 'package:g3m/stimpack_core.dart';
import 'package:g3m/stimpack_meta.dart';
import 'package:g3m/stimpack_meta_techlab.dart';
import 'package:g3m/stimpack_model.dart';
import 'package:g3m/stimpack_rbac.dart';

void main() {
  genRestPack();
}

void genRestPack() {
  final m = stimpack.model;
  final t = m.type, f = m.field;
  final meta = m.package.of(name: 'rest');

  // Normal apis
  final tApi = t.symbolOf(name: 'api', package: meta);
  final tApiRequest = t.symbolOf(name: 'api request', package: meta);
  final tApiResponse = t.symbolOf(name: 'api response', package: meta);

  /// Crud apis
  final tCrudApi = t.symbolOf(name: 'crud api', package: meta);
  final tCrudCreateOneApi =
      t.symbolOf(name: 'crud create one api', package: meta);
  final tCrudUpdateOneApi =
      t.symbolOf(name: 'crud update one api', package: meta);
  final tCrudFindOneApi = t.symbolOf(name: 'crud find one api', package: meta);
  final tCrudDeleteOneApi =
      t.symbolOf(name: 'crud delete one api', package: meta);
  final tCrudFindApi = t.symbolOf(name: 'crud find api', package: meta);
  final tCrudDeleteApi = t.symbolOf(name: 'crud delete api', package: meta);

  // ---------------------------------------------------------------------------
  // Fields definitions
  // ---------------------------------------------------------------------------

  final fComment = f.of(name: 'comment', type: t.string);

  // streamed is a boolean field. If this is true, the the request/response
  // object should be streamed. This is for grpc api.
  final fStreamed = f.of(name: 'streamed', type: t.bool);
  final fIdField = f.of(name: 'id field', type: t.model.field);
  final fRequiredIdField = fIdField.copyWith()..required();

  // A data model that can be associated to an api.
  final fRequiredModel = f.of(name: 'model', type: t.model.type)..required();

  // This is the list of model fields attached to an api request.
  // Each rule should have validations, and potential filter set on
  // the field.
  final fFieldSet = f.of(name: 'fields', type: t.model.fieldSet);

  // The security policy applied on the request.
  final fRbacPolicy = f.of(name: 'policy', type: t.rbac.policy);

  final fRequiredApi = f.of(name: 'api', type: tApi)..required();
  final fRequiredApiRequest = f.of(name: 'request', type: tApiRequest)
    ..required();
  final fRequiredApiResponse = f.of(name: 'response', type: tApiResponse)
    ..required();

  // ---------------------------------------------------------------------------
  // Normal API field definitions
  // ---------------------------------------------------------------------------

  // request and response have similar structure. should
  // have a list of model fields, and a boolean determined if it is a stream
  // or not.
  tApiRequest.fields = {
    fStreamed,
    fRequiredModel,
    fComment,
  };

  tApiResponse.fields = {
    fStreamed,
    fRequiredModel,
    fComment,
  };

  tApi.fields = {
    // The request has security policy required to executes the api.
    fRbacPolicy,

    // The request body
    fRequiredApiRequest,

    // The response body
    fRequiredApiResponse,
    fComment,
  };

  // ---------------------------------------------------------------------------
  // Crud API field definitions
  // ---------------------------------------------------------------------------

  final crudOneApis = {
    tCrudCreateOneApi,
    tCrudUpdateOneApi,
    tCrudFindOneApi,
    tCrudDeleteOneApi
  };

  final allCrudApis = crudOneApis + tCrudDeleteApi + tCrudFindApi;

  /// All crud one apis should have an optional id field.
  for (final api in crudOneApis) {
    api.fields += fIdField;
  }

  /// All crud apis should have security policy and a response.
  for (final api in allCrudApis) {
    api.fields += {fRequiredApi, fComment};
  }

  tCrudApi.fields = {
    // The data model affected by these apis.
    fRequiredModel,

    // Marks which field in the data model is the id field.
    fRequiredIdField,

    // sub apis
    f.of(name: 'create one', type: tCrudCreateOneApi),
    f.of(name: 'update one', type: tCrudUpdateOneApi),
    f.of(name: 'find one', type: tCrudFindOneApi),
    f.of(name: 'delete one', type: tCrudDeleteOneApi),
    f.of(name: 'find', type: tCrudFindApi),
    f.of(name: 'delete', type: tCrudDeleteApi),
  };

  stimpackGen(meta, 'lib/src/stimpack', values: {
    t.rbac.resource: {'rest api'},
  });
}
