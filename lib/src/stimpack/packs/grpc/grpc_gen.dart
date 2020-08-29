import 'package:g3m/stimpack_base.dart';
import 'package:g3m/stimpack_meta.dart';
import 'package:g3m/stimpack_model.dart';

final m = stimpack.meta,
    t = m.type,
    f = m.field,
    p = m.preset,
    v = m.value,
    k = m.kind;

void main() {
  final tPackage = t.of('package'),
      tMessage = t.of('message'),
      tService = t.of('service'),
      tMethod = t.of('method'),
      tMethodRequest = t.of('method request'),
      tMethodResponse = t.of('method response');

  final model = stimpack.model.meta;
  final modelType = model.types.firstWhereNameIs('type');
  assert(modelType != null);
  assert(modelType.pack != null);

  // ---------------------------------------------------------------------------
  // Field settings
  // ---------------------------------------------------------------------------
  final fType = f.of('type', type: modelType);
  final fMessages = f.listOf('messages', type: tMessage);
  final fServices = f.listOf('services', type: tService);
  final fMethods = f.listOf('methods', type: tMethod);
  final fMethodRequest = f.of('request', type: tMethodRequest);
  final fMethodResponse = f.of('response', type: tMethodResponse);

  tPackage.fields += fMessages + fServices;
  tMessage.fields += fType;
  tService.fields += fMethods;
  tMethod.fields += fMethodRequest + fMethodResponse;

  // ---------------------------------------------------------------------------
  // Preset settings
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // Build final pack
  // ---------------------------------------------------------------------------
  final allTypes = tPackage +
      tMessage +
      tMethod +
      tMethodRequest +
      tMethodResponse +
      tService;
  final meta = m.pack.of('grpc', types: allTypes);
  allTypes.pack.set(meta);

  stimpackGen(meta, 'lib/src/stimpack/packs/grpc/generated');
}
