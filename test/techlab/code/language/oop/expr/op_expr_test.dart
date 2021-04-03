import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('CodeEqualExpr', () {
    const s1 = '1 == 2';
    oopRunAndExpect(
      CodeEqualExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeNotEqualExpr', () {
    const s1 = '1 != 2';
    oopRunAndExpect(
      CodeNotEqualExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeGreaterThanExpr', () {
    const s1 = '1 > 2';
    oopRunAndExpect(
      CodeGreaterThanExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeGreaterThanOrEqualExpr', () {
    const s1 = '1 >= 2';
    oopRunAndExpect(
      CodeGreaterThanOrEqualExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeLessThanExpr', () {
    const s1 = '1 < 2';
    oopRunAndExpect(
      CodeLessThanExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeLessThanOrEqualExpr', () {
    const s1 = '1 <= 2';
    oopRunAndExpect(
      CodeLessThanOrEqualExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeAsExpr', () {
    const s1 = 'a as b';
    const s2 = '((b) a)';
    oopRunAndExpect(
      CodeAsExpr.of('a', 'b'),
      dart: s1,
      typescript: s1,
      java: s2,
      kotlin: s1,
    );
  });

  group('CodeIsExpr', () {
    const s1 = 'a is b';
    const s2 = 'a instanceof b';
    oopRunAndExpect(
      CodeIsExpr.of('a', 'b'),
      dart: s1,
      typescript: s2,
      java: s2,
      kotlin: s1,
    );
  });

  group('CodeIsNotExpr', () {
    oopRunAndExpect(
      CodeIsNotExpr.of('a', 'b'),
      dart: 'a is! b',
      typescript: 'a !instanceof b',
      java: '!(a instanceof b)',
      kotlin: 'a !is b',
    );
  });

  group('CodePlusExpr', () {
    const s1 = '1 + 2';
    oopRunAndExpect(
      CodePlusExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeMinusExpr', () {
    const s1 = '1 - 2';
    oopRunAndExpect(
      CodeMinusExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeMultiplyExpr', () {
    const s1 = '1 * 2';
    oopRunAndExpect(
      CodeMultiplyExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeDivideExpr', () {
    const s1 = '1 / 2';
    oopRunAndExpect(
      CodeDivideExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeDivExpr', () {
    const s1 = '1 ~/ 2';
    const s2 = '1 / 2';

    oopRunAndExpect(
      CodeDivExpr.of(1, 2),
      dart: s1,
      typescript: s2,
      java: s2,
      kotlin: s2,
    );
  });

  group('CodeModExpr', () {
    const s1 = '1 % 2';
    oopRunAndExpect(
      CodeModExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeBitShiftLeftExpr', () {
    const s1 = '1 << 2';
    const s2 = '1 shl 2';
    oopRunAndExpect(
      CodeBitShiftLeftExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s2,
    );
  });

  group('CodeBitShiftRightExpr', () {
    const s1 = '1 >> 2';
    const s2 = '1 shr 2';
    oopRunAndExpect(
      CodeBitShiftRightExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s2,
    );
  });

  group('CodeBitAndExpr', () {
    const s1 = '1 & 2';
    const s2 = '1 and 2';
    oopRunAndExpect(
      CodeBitAndExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s2,
    );
  });

  group('CodeBitOrExpr', () {
    const s1 = '1 | 2';
    const s2 = '1 or 2';
    oopRunAndExpect(
      CodeBitOrExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s2,
    );
  });

  group('CodeBitXorExpr', () {
    const s1 = '1 ^ 2';
    const s2 = '1 xor 2';
    oopRunAndExpect(
      CodeBitXorExpr.of(1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s2,
    );
  });

  group('CodeBitNegateExpr', () {
    const s1 = '~1';
    const s2 = '1.inv()';
    oopRunAndExpect(
      CodeBitNegateExpr.of(1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s2,
    );
  });

  group('CodeAssignExpr', () {
    const s1 = 'a = 1';
    oopRunAndExpect(
      CodeAssignExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeAssignIfNullExpr', () {
    const s1 = 'a ??= 1';
    const s2 = 'a = a == null? 1 : a';
    const s3 = 'a = if (a == null) 1 else a';

    oopRunAndExpect(
      CodeAssignIfNullExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s2,
      kotlin: s3,
    );
  });

  group('CodePlusAssignExpr', () {
    const s1 = 'a += 1';
    oopRunAndExpect(
      CodePlusAssignExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeMinusAssignExpr', () {
    const s1 = 'a -= 1';
    oopRunAndExpect(
      CodeMinusAssignExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeMultiplyAssignExpr', () {
    const s1 = 'a *= 1';
    oopRunAndExpect(
      CodeMultiplyAssignExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeDivideAssignExpr', () {
    const s1 = 'a /= 1';
    oopRunAndExpect(
      CodeDivideAssignExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeModAssignExpr', () {
    const s1 = 'a %= 1';
    oopRunAndExpect(
      CodeModAssignExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeBitShiftLeftAssignExpr', () {
    const s1 = 'a <<= 1';
    const s2 = 'a = a shl 1';
    oopRunAndExpect(
      CodeBitShiftLeftAssignExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s2,
    );
  });

  group('CodeBitShiftRightAssignExpr', () {
    const s1 = 'a >>= 1';
    const s2 = 'a = a shr 1';
    oopRunAndExpect(
      CodeBitShiftRightAssignExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s2,
    );
  });

  group('CodeBitAndAssignExpr', () {
    const s1 = 'a &= 1';
    const s2 = 'a = a and 1';
    oopRunAndExpect(
      CodeBitAndAssignExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s2,
    );
  });

  group('CodeBitOrAssignExpr', () {
    const s1 = 'a |= 1';
    const s2 = 'a = a or 1';
    oopRunAndExpect(
      CodeBitOrAssignExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s2,
    );
  });

  group('CodeBitXorAssignExpr', () {
    const s1 = 'a ^= 1';
    const s2 = 'a = a xor 1';
    oopRunAndExpect(
      CodeBitXorAssignExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s2,
    );
  });

  group('CodeLogicalNotExpr', () {
    const s1 = '!a';
    oopRunAndExpect(
      CodeLogicalNotExpr.of('a'),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeLogicalAndExpr', () {
    const s1 = 'a && 1';
    oopRunAndExpect(
      CodeLogicalAndExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeLogicalOrExpr', () {
    const s1 = 'a || 1';
    oopRunAndExpect(
      CodeLogicalOrExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeConditionalExpr', () {
    const s1 = 'a ? 1 : 2';
    const s2 = 'if (a) 1 else 2';
    oopRunAndExpect(
      CodeConditionalExpr.of('a', 1, 2),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s2,
    );
  });

  group('CodeConditionalNullExpr', () {
    const s1 = 'a ?? 1';
    const s2 = 'if (a == null) 1 else a';
    oopRunAndExpect(
      CodeConditionalNullExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s2,
    );
  });

  group('CodeAccessExpr', () {
    const s1 = 'a.b';
    oopRunAndExpect(
      CodeAccessExpr.of('a', 'b'),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeCascadeExpr', () {
    const s1 = '..a';
    oopRunAndExpect(
      CodeCascadeExpr.of('a'),
      dart: s1,
    );
  });

  group('CodeConditionalAccessExpr', () {
    const s1 = 'a?.b';
    const s2 = '(a == null? null : a.b)';
    oopRunAndExpect(
      CodeConditionalAccessExpr.of('a', 'b'),
      dart: s1,
      typescript: s1,
      java: s2,
      kotlin: s1,
    );
  });

  group('CodeListAccessExpr', () {
    const s1 = 'a[1]';
    oopRunAndExpect(
      CodeListAccessExpr.of('a', 1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeArrowExpr', () {
    const s1 = ' => 1';
    oopRunAndExpect(
      CodeArrowExpr.of(1),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeYieldExpr', () {
    const s1 = 'yield i';
    oopRunAndExpect(
      CodeYieldExpr.of('i'),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeYieldAsyncExpr', () {
    const s1 = 'yield* i';
    oopRunAndExpect(
      CodeYieldAsyncExpr.of('i'),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeAwaitExpr', () {
    const s1 = 'await i';
    oopRunAndExpect(
      CodeAwaitExpr.of('i'),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeBreakExpr', () {
    const s1 = 'break';
    oopRunAndExpect(
      CodeBreakExpr(),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeContinueExpr', () {
    const s1 = 'continue';
    oopRunAndExpect(
      CodeContinueExpr(),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('CodeReturnExpr', () {
    group('no value', () {
      const s1 = 'return';
      oopRunAndExpect(
        CodeReturnExpr(),
        dart: s1,
        typescript: s1,
        java: s1,
        kotlin: s1,
      );
    });

    group('with value', () {
      const s1 = 'return 1';
      oopRunAndExpect(
        CodeReturnExpr.of(1),
        dart: s1,
        typescript: s1,
        java: s1,
        kotlin: s1,
      );
    });

    group('with null', () {
      const s1 = 'return null';
      oopRunAndExpect(
        CodeReturnExpr.ofNull(),
        dart: s1,
        typescript: s1,
        java: s1,
        kotlin: s1,
      );
    });

    group('with true', () {
      const s1 = 'return true';
      oopRunAndExpect(
        CodeReturnExpr.ofTrue(),
        dart: s1,
        typescript: s1,
        java: s1,
        kotlin: s1,
      );
    });

    group('with false', () {
      const s1 = 'return false';
      oopRunAndExpect(
        CodeReturnExpr.ofFalse(),
        dart: s1,
        typescript: s1,
        java: s1,
        kotlin: s1,
      );
    });
  });
}
