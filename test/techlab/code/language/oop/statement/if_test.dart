import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('simple', () {
    const s1 = 'if (true) {\n'
        '  hello();\n'
        '}\n';

    oopRunAndExpect(
      CodeIf.of(
        condition: true,
        then: CodeFunctionCall.of(name: 'hello'),
      ),
    );
  });

  group('with else', () {
    const s1 = 'if (true) {\n'
        '  return true;\n'
        '} else {\n'
        '  return false;\n'
        '}';

    oopRunAndExpect(
      CodeIf.of(
        condition: true,
        then: CodeReturn.of(true),
        orElse: CodeReturn.of(false),
      ),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('with else if', () {
    const s1 = 'if (true) {\n'
        '  hello();\n'
        '} else if (false) {\n'
        '  return 1;\n'
        '} else if (false) {\n'
        '  return 2;\n'
        '} else {\n'
        '  world();\n'
        '}';

    oopRunAndExpect(
      CodeIf.of(condition: true, then: [
        'hello();'
      ], elseIfs: [
        CodeElseIf.of(condition: false, then: CodeReturn.of(1)),
        CodeElseIf.of(condition: false, then: CodeReturn.of(2)),
      ], orElse: [
        CodeFunctionCall.of(name: 'world'),
      ]),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });
}
