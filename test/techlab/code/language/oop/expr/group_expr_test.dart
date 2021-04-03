import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('null', () {
    const s1 = '';
    oopRunAndExpect(
      CodeGroupExpr.of(null),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('empty', () {
    const s1 = '';
    oopRunAndExpect(
      CodeGroupExpr.of([]),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('1 expr', () {
    const s1 = '(\'a\' == \'b\')';
    const s2 = '("a" == "b")';
    oopRunAndExpect(
      CodeGroupExpr.of([
        CodeEqualExpr.of('a', 'b'),
      ]),
      dart: s1,
      typescript: s1,
      java: s2,
      kotlin: s2,
    );
  });

  group('2 expr', () {
    const s1 = '(\'a\' == \'b\' && \'a\' != \'b\', null)';
    const s2 = '("a" == "b" && "a" != "b", null)';
    oopRunAndExpect(
      CodeGroupExpr.of([
        CodeLogicalAndExpr.of(
          CodeEqualExpr.of('a', 'b'),
          CodeNotEqualExpr.of('a', 'b'),
        ),
        CodeNullLiteral(),
      ]),
      dart: s1,
      typescript: s1,
      java: s2,
      kotlin: s2,
    );
  });
}
