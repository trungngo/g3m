import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('simple', () {
    const s1 = 'String name';
    const s2 = 'let name: string';
    const s3 = 'var name: String';

    oopRunAndExpect(
      CodeVar.of(name: 'name', type: 'string'),
      dart: s1,
      typescript: s2,
      java: s1,
      kotlin: s3,
    );
  });

  group('with string init', () {
    const s1 = 'final String name = \'john doe\'';
    const s2 = 'const name: string = \'john doe\'';
    const s3 = 'final String name = "john doe"';
    const s4 = 'val name: String = "john doe"';

    oopRunAndExpect(
      CodeVar.of(
        name: 'name',
        type: 'string',
        init: CodeStringLiteral.of('john doe'),
        isFinal: true,
      ),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s4,
    );
  });
}
