import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('no body', () {
    group('name only', () {
      const s1 = '\n'
          'void hello()';
      const s2 = '\n'
          'hello(): void';
      const s3 = '\n'
          'fun hello()';

      oopRunAndExpect(
        CodeFunction.of(name: 'hello'),
        dart: s1,
        typescript: s2,
        java: s1,
        kotlin: s3,
      );
    });

    group('with args - simple form', () {
      const s1 = '\n'
          'void myHello(String name, MyPerson another, Pattern message)';
      const s2 = '\n'
          'myHello(name: string, another: MyPerson, message: Pattern): void';
      const s3 = '\n'
          'fun myHello(name: String, another: MyPerson, message: Pattern)';
      oopRunAndExpect(
        CodeFunction.of(
          name: 'my hello',
          requiredArgs: [
            ['name', 'String'],
            CodeArg.of(name: 'another', type: 'my person'),
            CodeArg.of(name: 'message', type: CodeType.of(name: 'pattern')),
          ],
        ),
        dart: s1,
        typescript: s2,
        java: s1,
        kotlin: s3,
      );
    });

    group('with return - full ', () {
      const s1 = '\n'
          'String hello()';
      const s2 = '\n'
          'hello(): string';
      const s3 = '\n'
          'fun hello(): String';

      oopRunAndExpect(
        CodeFunction.of(
          name: 'hello',
          returns: CodeFunctionReturn.of(type: 'string'),
        ),
        dart: s1,
        typescript: s2,
        java: s1,
        kotlin: s3,
      );
    });

    group('with return - simple ', () {
      const s1 = '\n'
          'String hello()';
      const s2 = '\n'
          'hello(): string';
      const s3 = '\n'
          'fun hello(): String';
      oopRunAndExpect(
        CodeFunction.of(
          name: 'hello',
          returns: 'string',
        ),
        dart: s1,
        typescript: s2,
        java: s1,
        kotlin: s3,
      );
    });

    group('with return - type ', () {
      const s1 = '\n'
          'String hello()';
      const s2 = '\n'
          'hello(): string';
      const s3 = '\n'
          'fun hello(): String';
      oopRunAndExpect(
        CodeFunction.of(
          name: 'hello',
          returns: CodeType.ofString(),
        ),
        dart: s1,
        typescript: s2,
        java: s1,
        kotlin: s3,
      );
    });

    group('with annotation', () {
      const s1 = '\n'
          '@Repository()\n'
          '@Repository(1, false)\n'
          'void hello()';
      const s2 = '\n'
          '@Repository()\n'
          '@Repository(1, false)\n'
          'hello(): void';
      const s3 = '\n'
          '@Repository()\n'
          '@Repository(1, false)\n'
          'fun hello()';

      oopRunAndExpect(
        CodeFunction.of(
          name: 'hello',
          annotations: [
            CodeAnnotation.constructorCall(className: 'repository'),
            CodeAnnotation.constructorCall(
                className: 'repository', args: [1, false]),
          ],
        ),
        dart: s1,
        typescript: s2,
        java: s1,
        kotlin: s3,
      );
    });

    group('with access', () {
      const s1 = '\n'
          '@override\n'
          'static void _hello()';
      const s2 = '\n'
          '@override\n'
          'private static hello(): void';
      const s3 = '\n'
          '@override\n'
          'private static void hello()';
      const s4 = '\n'
          '@override\n'
          'private static fun hello()';

      oopRunAndExpect(
        CodeFunction.of(
          name: 'hello',
          isOverride: true,
          isPrivate: true,
          isStatic: true,
        ),
        dart: s1,
        typescript: s2,
        java: s3,
        kotlin: s4,
      );
    });

    group('with generic', () {
      const s1 = '\n'
          'void hello<T>(T name)';
      const s2 = '\n'
          'hello<T>(name: T): void';
      const s3 = '\n'
          'fun hello<T>(name: T)';

      oopRunAndExpect(
        CodeFunction.of(
          name: 'hello',
          generic: ['T'],
          requiredArgs: [
            ['name', 'T'],
          ],
        ),
        dart: s1,
        typescript: s2,
        java: s1,
        kotlin: s3,
      );
    });

    group('with throw', () {
      const s1 = '\n'
          'void hello()';
      const s2 = '\n'
          'hello(): void';
      const s3 = '\n'
          'void hello() throws InvalidArgumentException';
      const s4 = '\n'
          '@Throws(InvalidArgumentException::class)\n'
          'fun hello()';

      oopRunAndExpect(
        CodeFunction.of(
          name: 'hello',
          throws: ['invalid argument exception'],
        ),
        dart: s1,
        typescript: s2,
        java: s3,
        kotlin: s4,
      );
    });
  });

  group('with body', () {
    group('name only', () {
      const s1 = '\n'
          'void hello() {\n'
          '  callAFunction();\n'
          '}';
      const s2 = '\n'
          'hello(): void {\n'
          '  callAFunction();\n'
          '}';
      const s3 = '\n'
          'fun hello() {\n'
          '  callAFunction();\n'
          '}';
      oopRunAndExpect(
        CodeFunction.of(
          name: 'hello',
          body: [
            'callAFunction();\n',
          ],
        ),
        dart: s1,
        typescript: s2,
        java: s1,
        kotlin: s3,
      );
    });
  });
}
