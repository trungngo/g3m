import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void main() {
  group('null', () {
    const s1 = 'null';
    oopRunAndExpect(
      CodeStringLiteral.of(null),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('has value', () {
    const s1 = '\'a\'';
    const s2 = '"a"';

    oopRunAndExpect(
      CodeStringLiteral.of('a'),
      dart: s1,
      typescript: s1,
      java: s2,
      kotlin: s2,
    );
  });
}
