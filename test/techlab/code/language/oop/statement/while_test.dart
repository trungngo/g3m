import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('with null body', () {
    const s1 = 'while (true) {}\n';

    oopRunAndExpect(
      CodeWhile.of(
        condition: true,
      ),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });
  group('with no body', () {
    const s1 = 'while (true) {}\n';

    oopRunAndExpect(
      CodeWhile.of(
        condition: true,
        body: [],
      ),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('with body', () {
    const s1 = 'while (true) {\n'
        '  print("Hello World!");\n'
        '}\n';

    oopRunAndExpect(
      CodeWhile.of(
        condition: true,
        body: [
          'print("Hello World!");',
        ],
      ),
      // https://www.tutorialspoint.com/dart_programming/dart_programming_while_loop.htm
      dart: s1,
      // https://www.tutorialspoint.com/typescript/typescript_while_loop.htm
      typescript: s1,
      // https://www.w3schools.com/java/java_while_loop.asp
      java: s1,
      // https://kotlinlang.org/docs/reference/control-flow.html#while-loops
      kotlin: s1,
    );
  });
}
