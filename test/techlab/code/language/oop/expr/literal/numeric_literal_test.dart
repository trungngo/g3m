import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void main() {
  group('null', () {
    const s1 = 'null';
    oopRunAndExpect(
      CodeNumericLiteral.of(null),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('from a string', () {
    const s1 = '1';
    oopRunAndExpect(
      CodeNumericLiteral.of(1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('from a number', () {
    const s1 = '2';
    oopRunAndExpect(
      CodeNumericLiteral.of(2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });
}
