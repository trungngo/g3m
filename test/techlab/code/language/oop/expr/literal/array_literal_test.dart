import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void main() {
  group('null', () {
    const s1 = 'null';
    oopRunAndExpect(
      CodeArrayLiteral.of(null),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('empty array', () {
    const s1 = '[]';
    oopRunAndExpect(
      CodeArrayLiteral.of([]),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('non empty array', () {
    const s1 = '[\n'
        '  false,\n'
        '  null,\n'
        '  \'A\'\n'
        ']';

    const s2 = '[\n'
        '  false,\n'
        '  null,\n'
        '  "A"\n'
        ']';


    oopRunAndExpect(
      CodeArrayLiteral.of([false, null, 'A']),
      dart: s1,
      typescript: s1,
      java: s2,
      kotlin: s2,
    );
  });
}
