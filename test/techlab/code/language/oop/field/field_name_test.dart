import 'package:g3m/techlab_core.dart';
import 'package:g3m/techlab_dart.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  const s1 = 'helloWorld';
  const s2 = '_helloWorld';

  group('string', () {
    oopRunAndExpect(
      CodeFieldName.of(name: 'hello world'),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('node', () {
    oopRunAndExpect(
      CodeFieldName.of(name: Text('hello world')),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('name of another name', () {
    var anotherName = CodeEnumValueName.of(name: 'hello world');
    oopRunAndExpect(
      CodeFieldName.of(name: anotherName),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('with private final', () {
    oopRunAndExpect(
      CodeFieldName.of(
        name: 'hello world',
        isPrivate: true,
        isFinal: true,
      ),
      dart: s2,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });
}
