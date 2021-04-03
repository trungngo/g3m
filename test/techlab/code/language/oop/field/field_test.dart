import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('simple', () {
    const s1 = '\n'
        'String firstName';

    const s2 = '\n'
        'firstName: string';

    const s3 = '\n'
        'var firstName: String';

    oopRunAndExpect(
      CodeField.of(
        name: 'first name',
        type: 'string',
      ),
      dart: s1,
      typescript: s2,
      java: s1,
      kotlin: s3,
    );
  });

  group('with statement', () {
    const s1 = '\n'
        'String firstName;\n';

    const s2 = '\n'
        'firstName: string;\n';

    const s3 = '\n'
        'var firstName: String;\n';

    oopRunAndExpect(
      CodeStatement.of(
        CodeField.of(
          name: 'first name',
          type: 'string',
        ),
      ),
      dart: s1,
      typescript: s2,
      java: s1,
      kotlin: s3,
    );
  });

  group('with init', () {
    const s1 = '\n'
        'String firstName = \'john\'';
    const s2 = '\n'
        'firstName: string = \'john\'';
    const s3 = '\n'
        'String firstName = "john"';
    const s4 = '\n'
        'var firstName: String = "john"';
    oopRunAndExpect(
      CodeField.of(
        name: 'first name',
        type: 'string',
        init: CodeStringLiteral.of('john'),
      ),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s4,
    );
  });

  group('with init', () {
    oopRunAndExpect(
      CodeField.of(
        name: 'first name',
        type: 'string',
        isPrivate: true,
        isStatic: true,
      ),
      dart: '\n'
          'static String _firstName',
      typescript: '\n'
          'private static firstName: string',
      java: '\n'
          'private static String firstName',
      kotlin: '\n'
          'private var firstName: String',
    );
  });

  group('with comment', () {
    oopRunAndExpect(
      CodeField.of(
        name: 'first name',
        type: 'string',
        comment: 'hello',
      ),
      dart: '\n'
          '/// hello\n'
          'String firstName',
      typescript: '\n'
          '// hello\n'
          'firstName: string',
      java: '\n'
          '// hello\n'
          'String firstName',
      kotlin: '\n'
          '// hello\n'
          'var firstName: String',
    );
  });
}
