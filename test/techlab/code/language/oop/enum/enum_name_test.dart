import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  const s1 = 'HelloWorld';

  group('string', () {
    oopRunAndExpect(
      CodeEnumName.of(name: 'hello world'),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('node', () {
    oopRunAndExpect(
      CodeEnumName.of(name: Text('hello world')),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('name of another name', () {
    // Runs with dart config
    oopRunAndExpect(
      CodeEnumName.of(
        name: CodeArgName.of(name: 'hello world'),
      ),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });
}
