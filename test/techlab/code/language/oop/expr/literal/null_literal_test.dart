import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void main() {
  group('null', () {
    const s1 = 'null';
    oopRunAndExpect(
      CodeNullLiteral(),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });
}
