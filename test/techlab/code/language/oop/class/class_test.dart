import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {

  group('comment', () {
    group('empty', () {
      const s1 = '\n'
          'class Person {\n'
          '\n'
          '}\n';
      oopRunAndExpect(
        CodeClass.of(name: 'person'),
        java: s1,
      );
    });

    group('with code access', () {
      const s1 = '\n'
          'private abstract class Person {\n'
          '\n'
          '}\n';
      oopRunAndExpect(
        CodeClass.of(
          name: 'person',
          isPrivate: true,
          isAbstract: true,
        ),
        java: s1,
      );
    });

    group('with comment', () {
      const s1 = '\n'
          '/**\n'
          ' * hello world\n'
          ' */\n'
          'class Person {\n'
          '\n'
          '}\n';

      oopRunAndExpect(
        CodeClass.of(
          name: 'person',
          comment: 'hello world',
        ),
        java: s1,
      );
    });

    group('with field', () {
      const s1 = '\n'
          'class Person {\n'
          '  String firstName;\n'
          '}\n';

      oopRunAndExpect(
        CodeClass.of(
          name: 'person',
          fields: [
            makeField('first name'),
          ],
        ),
        java: s1,
      );
    });

    group('with field list', () {
      const s1 = '\n'
          'class Person {\n'
          '  String firstName;\n'
          '\n'
          '  String lastName;\n'
          '}\n';

      oopRunAndExpect(
        CodeClass.of(
          name: 'person',
          fields: [
            makeField('first name'),
            makeField('last name'),
          ],
        ),
        java: s1,
      );
    });

    group('with function list', () {
      const s1 = '\n'
          'class Person {\n'
          '  /**\n'
          '   * test hello world 1\n'
          '   */\n'
          '  String helloWorld1(String name, Person other);\n'
          '\n'
          '  /**\n'
          '   * test hello world 2\n'
          '   */\n'
          '  String helloWorld2(String name, Person other);\n'
          '}\n';

      oopRunAndExpect(
        CodeClass.of(
          name: 'person',
          functions: [
            makeFunction('hello world 1'),
            makeFunction('hello world 2'),
          ],
        ),
        java: s1,
      );
    });

    group('with all ', () {
      final generic = [
        CodeGenericParam.of(name: 't'),
      ];

      final extend = null;

      final implements = null;

      final fields = [
        makeField('first name'),
        makeField('last name'),
      ];

      final functions = [
        makeFunction('hello world 1'),
        makeFunction('hello world 2'),
      ];
      const s1 = '\n'
          'public abstract class Person<T> {\n'
          '  String firstName;\n'
          '\n'
          '  String lastName;\n'
          '\n'
          '  /**\n'
          '   * test hello world 1\n'
          '   */\n'
          '  String helloWorld1(String name, Person other);\n'
          '\n'
          '  /**\n'
          '   * test hello world 2\n'
          '   */\n'
          '  String helloWorld2(String name, Person other);\n'
          '}\n';
      oopRunAndExpect(
        CodeClass.of(
          name: 'person',
          isPublic: true,
          isAbstract: true,
          generic: generic,
          extend: extend,
          implements: implements,
          fields: fields,
          functions: functions,
        ),
        java: s1,
      );
    });
  });
}

CodeField makeField(String name) => CodeField.of(
      name: name,
      type: 'string',
    );

CodeFunction makeFunction(String name) => CodeFunction.of(
      name: name,
      returns: ['string'],
      requiredArgs: [
        ['name', 'String'],
        ['other', 'Person'],
      ],
      comment: 'test $name',
    );
