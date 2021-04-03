import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('generic param', () {
    const s1 = 'HelloWorld';
    oopRunAndExpect(
      CodeGenericParam.of(name: 'hello world'),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });
}
