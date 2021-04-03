import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  const s1 = 'helloWorld';

  group('string', () {
    oopRunAndExpect(
      CodeArgName.of(name: 'hello world'),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('node', () {
    oopRunAndExpect(
      CodeArgName.of(name: Text('hello world')),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('name of another name', () {
    var anotherName = CodeEnumValueName.of(name: 'hello world');
    oopRunAndExpect(
      CodeArgName.of(name: anotherName),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('with java private final', () {
    oopRunAndExpect(
      CodeArgName.of(
        name: 'hello world',
        isPrivate: true,
      ),
      dart: '_helloWorld',
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });
}
