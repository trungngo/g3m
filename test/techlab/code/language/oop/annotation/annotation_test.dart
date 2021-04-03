import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('no args - as is ', () {
    final code = CodeAnnotation.of('required');
    const s1 = '@required';
    oopRunAndExpect(
      code,
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('no args - as is - 2', () {
    // The annotation is not modified
    final code = CodeAnnotation.of('Required');
    const s1 = '@Required';
    oopRunAndExpect(
      code,
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('no args - required', () {
    final code = CodeAnnotation.required();
    const s1 = '@required';
    oopRunAndExpect(
      code,
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('no args - override', () {
    final code = CodeAnnotation.override();
    const s1 = '@override';
    oopRunAndExpect(
      code,
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('one arg', () {
    const s1 = '@HelloWorld(1)';
    final code = CodeAnnotation.constructorCall(
      className: 'hello world',
      args: [1],
    );

    oopRunAndExpect(
      code,
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('more than one', () {
    const s1 = '@HelloWorld(true, 1)';
    final code = CodeAnnotation.constructorCall(
      className: 'hello world',
      args: [
        true,
        1,
      ],
    );

    oopRunAndExpect(
      code,
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });
}
