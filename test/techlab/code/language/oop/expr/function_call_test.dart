import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('no args', () {
    const s1 = 'helloWorld()';
    oopRunAndExpect(
      CodeFunctionCall.of(name: 'hello world'),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('one arg', () {
    const s1 = 'helloWorld(1)';
    oopRunAndExpect(
      CodeFunctionCall.of(
        name: 'hello world',
        args: [1],
      ),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('more than one', () {
    const s2 = 'helloWorld("john doe", true, 1)';
    var s1 = s2.replaceAll('"', '\'');

    oopRunAndExpect(
      CodeFunctionCall.of(
        name: 'hello world',
        args: ['john doe', true, 1],
      ),
      dart: s1,
      typescript: s1,
      java: s2,
      kotlin: s2,
    );
  });
}
