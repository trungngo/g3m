import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void main() {
  group('null', () {
    const s1 = 'null';
    oopRunAndExpect(
      CodeBoolLiteral.of(null),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('true', () {
    const s1 = 'true';
    oopRunAndExpect(
      CodeBoolLiteral.of(true),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('false', () {
    const s1 = 'false';
    oopRunAndExpect(
      CodeBoolLiteral.of(false),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });
}
