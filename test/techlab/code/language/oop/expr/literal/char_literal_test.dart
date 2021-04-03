import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void main() {
  group('null', () {
    const s1 = 'null';
    oopRunAndExpect(
      CodeCharLiteral.of(null),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('has value', () {
    const s1 = '\'a\'';
    oopRunAndExpect(
      CodeCharLiteral.of('a'),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });
}
