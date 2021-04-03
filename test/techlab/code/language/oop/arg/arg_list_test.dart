import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  const empty = '';
  group('null', () {
    oopRunAndExpect(
      CodeArgList.of(required: null),
      dart: empty,
      typescript: empty,
      java: empty,
      kotlin: empty,
    );
  });

  group('empty', () {
    oopRunAndExpect(
      CodeArgList.of(required: ''),
      dart: empty,
      typescript: empty,
      java: empty,
      kotlin: empty,
    );
  });

  group('string', () {
    const s1 = 'helloWorld';
    oopRunAndExpect(
      CodeArgList.of(required: 'hello world'),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('node', () {
    const s1 = 'helloWorld';
    oopRunAndExpect(
      CodeArgList.of(required: Text('hello world')),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('name of another name', () {
    const s1 = 'helloWorld';
    oopRunAndExpect(
      CodeArgList.of(
        required: CodeEnumValueName.of(name: 'hello world'),
      ),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('long format', () {
    const s1 = 'int i, String s, bool b';
    const s2 = 'i: number, s: string, b: boolean';
    const s3 = 'int i, String s, boolean b';
    const s4 = 'i: Int, s: String, b: Boolean';
    oopRunAndExpect(
      CodeArgList.of(
        required: [
          CodeArg.of(name: 'i', type: CodeType.ofInteger()),
          CodeArg.of(name: 's', type: CodeType.ofString()),
          CodeArg.of(name: 'b', type: CodeType.ofBool()),
        ],
      ),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s4,
    );
  });
}
