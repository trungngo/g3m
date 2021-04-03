import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  const s1 = 'helloWorld';
  const s2 = 'HelloWorld';
  const s3 = 'HELLO_WORLD';

  group('string', () {
    oopRunAndExpect(
      CodeEnumValueName.of(name: 'hello world'),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s3,
    );
  });

  group('node', () {
    oopRunAndExpect(
      CodeEnumValueName.of(name: Text('hello world')),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s3,
    );
  });

  group('name of another name', () {
    // Runs with dart config
    oopRunAndExpect(
      CodeEnumValueName.of(
        name: CodeArgName.of(name: 'hello world'),
      ),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s3,
    );
  });
}
