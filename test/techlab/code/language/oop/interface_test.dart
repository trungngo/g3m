import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('empty', () {
    const s1 = '\n'
        'class Person {\n'
        '\n'
        '}\n';
    const s2 = '\n'
        'interface Person {\n'
        '\n'
        '}\n';
    oopRunAndExpect(
      CodeInterface.of(name: 'person'),
      dart: s1,
      typescript: s2,
      java: s2,
      kotlin: s2,
    );
  });

  group('with private', () {
    const s1 = '\n'
        'class _Person {\n'
        '\n'
        '}\n';

    const s2 = '\n'
        'private interface Person {\n'
        '\n'
        '}\n';

    oopRunAndExpect(
      CodeInterface.of(
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
        'class Person {\n'
        '\n'
        '}\n';
    const s2 = '\n'
        '/**\n'
        ' * hello world\n'
        ' */\n'
        'interface Person {\n'
        '\n'
        '}\n';
    const s3 = '\n'
        '/**\n'
        ' * hello world\n'
        ' */\n'
        'interface Person {\n'
        '\n'
        '}\n';
    oopRunAndExpect(
      CodeInterface.of(
        name: 'person',
        comment: 'hello world',
      ),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s3,
    );
  });

  group('with field', () {
    const s1 = '\n'
        'class Person {\n'
        '  String firstName;\n'
        '}\n';

    const s2 = '\n'
        'interface Person {\n'
        '  firstName: string;\n'
        '}\n';

    const s3 = '\n'
        'interface Person {\n'
        '  String firstName;\n'
        '}\n';

    const s4 = '\n'
        'interface Person {\n'
        '  var firstName: String;\n'
        '}\n';

    oopRunAndExpect(
      CodeInterface.of(
        name: 'person',
        fields: [
          CodeField.of(name: 'first name', type: CodeType.ofString()),
        ],
      ),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s4,
    );
  });

  group('with field list', () {
    const s1 = '\n'
        'class Person {\n'
        '  String firstName;\n'
        '\n'
        '  final String lastName;\n'
        '}\n';

    const s2 = '\n'
        'interface Person {\n'
        '  firstName?: string;\n'
        '\n'
        '  readonly lastName: string;\n'
        '}\n';
    const s3 = '\n'
        'interface Person {\n'
        '  String firstName;\n'
        '\n'
        '  String lastName;\n'
        '}\n';
    const s4 = '\n'
        'interface Person {\n'
        '  var firstName?: String;\n'
        '\n'
        '  val lastName: String;\n'
        '}\n';

    oopRunAndExpect(
      CodeInterface.of(
        name: 'person',
        fields: [
          CodeField.of(
            name: 'first name',
            type: CodeType.ofString(),
            isOptional: true,
          ),
          CodeField.of(
            name: 'last name',
            type: CodeType.ofString(),
            isFinal: true,
          ),
        ],
      ),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s4,
    );
  });

  group('with function list', () {
    const s1 = '\n'
        'class MyVehicle {\n'
        '  void noArgFunc();\n'
        '\n'
        '  List<int> withArgsFunc(String a1, [bool b1], {double c1});\n'
        '}\n'
        '';

    const s2 = '\n'
        'interface MyVehicle {\n'
        '  noArgFunc(): void;\n'
        '\n'
        '  withArgsFunc(a1: string, b1: boolean, c1: number): number[];\n'
        '}\n'
        '';
    const s3 = '\n'
        'interface MyVehicle {\n'
        '  void noArgFunc();\n'
        '\n'
        '  long[] withArgsFunc(String a1, boolean b1, double c1);\n'
        '}\n';

    const s4 = '\n'
        'interface MyVehicle {\n'
        '  fun noArgFunc();\n'
        '\n'
        '  fun withArgsFunc(a1: String, b1: Boolean, c1: Double): Array<Long>;\n'
        '}\n'
        '';

    oopRunAndExpect(
      CodeInterface.of(
        name: 'my vehicle',
        functions: [
          CodeFunction.of(name: 'noArgFunc'),
          CodeFunction.of(
            name: 'withArgsFunc',
            requiredArgs: [
              CodeArg.of(name: 'a1', type: CodeType.ofString()),
            ],
            optionalArgs: [
              CodeArg.of(name: 'b1', type: CodeType.ofBool()),
            ],
            namedArgs: [
              CodeArg.of(name: 'c1', type: CodeType.ofDouble()),
            ],
            returns: CodeType.arrayOfLong(),
          ),
        ],
      ),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s4,
    );
  });

  group('with generic ', () {
    const s1 = '\n'
        'abstract class Person<T> extends Car<T> {\n'
        '\n'
        '}\n'
        '';
    const s2 = '\n'
        'export abstract interface Person<T> extends Car<T> {\n'
        '\n'
        '}\n';

    const s3 = '\n'
        'public abstract interface Person<T> extends Car<T> {\n'
        '\n'
        '}\n';

    oopRunAndExpect(
      CodeInterface.of(
        name: 'person',
        isPublic: true,
        isAbstract: true,
        generic: CodeGenericParam.of(name: 't'),
        extend: CodeType.genericSingle('car', 't'),
      ),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s3,
    );
  });
}
