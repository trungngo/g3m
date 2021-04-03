import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('long syntax', () {
    group('empty', () {
      const s1 = '\n'
          'enum Person {}\n';

      oopRunAndExpect(
        CodeEnum.of(name: 'person'),
        dart: s1,
        typescript: s1,
        java: s1,
        kotlin: s1,
      );
    });

    group('with code access', () {
      const s1 = '\n'
          'enum _Person {}\n';

      const s2 = '\n'
          'private enum _Person {}\n';

      oopRunAndExpect(
        CodeEnum.of(
          name: 'person',
          isPrivate: true,
        ),
        dart: s1,
        typescript: s2,
        java: s2,
        kotlin: s2,
      );
    });

    group('with comment', () {
      const s1 = '\n'
          '/// hello world\n'
          'enum Person {}\n';

      const s2 = '\n'
          '/**\n'
          ' * hello world\n'
          ' */\n'
          'enum Person {}\n';

      oopRunAndExpect(
        CodeEnum.of(
          name: 'person',
          comment: 'hello world',
        ),
        dart: s1,
        typescript: s2,
        java: s2,
        kotlin: s2,
      );
    });

    group('with value', () {
      const s1 = '\n'
          'enum Person {\n'
          '  firstName\n'
          '}\n';

      const s2 = '\n'
          'enum Person {\n'
          '  FirstName\n'
          '}\n';

      const s3 = '\n'
          'enum Person {\n'
          '  FIRST_NAME\n'
          '}\n';

      oopRunAndExpect(
          CodeEnum.of(
            name: 'person',
            values: [
              CodeEnumValue.of(name: 'first name'),
            ],
          ),
          dart: s1,
          typescript: s2,
          java: s3,
          kotlin: s3);
    });

    group('with value list', () {
      const s1 = '\n'
          'enum Person {\n'
          '  firstName,\n'
          '  lastName\n'
          '}\n';

      const s2 = '\n'
          'enum Person {\n'
          '  FirstName,\n'
          '  LastName\n'
          '}\n';
      const s3 = '\n'
          'enum Person {\n'
          '  FIRST_NAME,\n'
          '  LAST_NAME\n'
          '}\n';

      oopRunAndExpect(
        CodeEnum.of(
          name: 'person',
          values: [
            CodeEnumValue.of(name: 'first name'),
            CodeEnumValue.of(name: 'last name'),
          ],
        ),
        dart: s1,
        typescript: s2,
        java: s3,
        kotlin: s3,
      );
    });
  });

  group('short syntax', () {
    group('with value', () {
      const s1 = '\n'
          'enum Person {\n'
          '  firstName\n'
          '}\n';

      const s2 = '\n'
          'enum Person {\n'
          '  FirstName\n'
          '}\n';

      const s3 = '\n'
          'enum Person {\n'
          '  FIRST_NAME\n'
          '}\n';

      oopRunAndExpect(
        CodeEnum.of(
          name: 'person',
          values: 'first name',
        ),
        dart: s1,
        typescript: s2,
        java: s3,
        kotlin: s3,
      );
    });

    group('with all ', () {
      const s1 = '\n'
          'enum _Person {\n'
          '  firstName,\n'
          '  lastName = \'john doe\',\n'
          '  /// this is a comment\n'
          '  age = 10\n'
          '}\n';

      const s2 = '\n'
          'private enum _Person {\n'
          '  FirstName,\n'
          '  LastName = \'john doe\',\n'
          '  /**\n'
          '   * this is a comment\n'
          '   */\n'
          '  Age = 10\n'
          '}\n';

      const s3 = '\n'
          'private enum _Person {\n'
          '  FIRST_NAME,\n'
          '  LAST_NAME = "john doe",\n'
          '  /**\n'
          '   * this is a comment\n'
          '   */\n'
          '  AGE = 10\n'
          '}\n';

      oopRunAndExpect(
        CodeEnum.of(
          name: 'person',
          isPrivate: true,
          values: [
            'first name',
            ['last name', 'john doe'],
            ['age', 10, 'this is a comment'],
          ],
        ),
        dart: s1,
        typescript: s2,
        java: s3,
        kotlin: s3,
      );
    });
  });
}
