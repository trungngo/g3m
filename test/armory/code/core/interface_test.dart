import 'package:g3m/g3armory.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void main() {
  group('comment', () {
    void run(Node Function() build, String expected) {
      var code = JavaCode(build());
      runAndExpect(code, expected);
    }

    test('empty', () {
      run(
        () => CodeInterface.of('person'),
        '\n'
        'interface Person {\n'
        '\n'
        '}\n',
      );
    });

    test('with code access', () {
      run(
        () => CodeInterface.of(
          'person',
          access: CodeAccess.private(),
        ),
        '\n'
        'private interface Person {\n'
        '\n'
        '}\n',
      );
    });

    test('with comment', () {
      run(
        () => CodeInterface.of(
          'person',
          comment: 'hello world',
        ),
        '\n'
        '/**\n'
        ' * hello world\n'
        ' */\n'
        'interface Person {\n'
        '\n'
        '}\n',
      );
    });

    test('with field', () {
      run(
        () => CodeInterface.of(
          'person',
          fields: [
            makeField('first name'),
          ],
        ),
        '\n'
        'interface Person {\n'
        '  String firstName;\n'
        '}\n',
      );
    });

    test('with field list', () {
      run(
        () => CodeInterface.of(
          'person',
          fields: [
            makeField('first name'),
            makeField('last name'),
          ],
        ),
        '\n'
        'interface Person {\n'
        '  String firstName;\n'
        '\n'
        '  String lastName;\n'
        '}\n',
      );
    });

    test('with function list', () {
      run(
        () {
          return CodeInterface.of(
            'person',
            functions: [
              function('hello world 1'),
              function('hello world 2'),
            ],
          );
        },
        '\n'
        'interface Person {\n'
        '  /**\n'
        '   * test hello world 1\n'
        '   */\n'
        '  String helloWorld1(String name, Person other);\n'
        '\n'
        '  /**\n'
        '   * test hello world 2\n'
        '   */\n'
        '  String helloWorld2(String name, Person other);\n'
        '}\n',
      );
    });

    test('with all ', () {
      run(
        () {
          final generic = [
            genericParam(),
          ];

          final extend = CodeType.genericSingle('car', genericParam());

          final fields = [
            makeField('first name'),
            makeField('last name'),
          ];

          final functions = [
            function('hello world 1'),
            function('hello world 2'),
          ];

          return CodeInterface.of(
            'person',
            access: CodeAccess.publicAbstract(),
            generic: generic,
            extend: [extend],
            fields: fields,
            functions: functions,
          );
        },
        '\n'
        'public abstract interface Person<T> extends Car<T> implements FourWheel, Vehicle<T> {\n'
        '  \n'
        '  \n'
        '  String firstName;\n'
        '  \n'
        '  String lastName;\n'
        '  \n'
        '  \n'
        '  /// test hello world 1\n'
        '  String helloWorld1(String name, Person other);\n'
        '  \n'
        '  /// test hello world 2\n'
        '  String helloWorld2(String name, Person other);\n'
        '  \n'
        '}\n',
      );
    });
  });
}

CodeGenericParam genericParam() => CodeGenericParam.of('t');

CodeField makeField(String name) => CodeField.of(
      name: name,
      type: 'string',
    );

CodeFunction function(String name) => CodeFunction.of(
      name,
      returns: ['string'],
      args: {
        'name': 'String',
        'other': 'Person',
      },
      comment: 'test $name',
    );
