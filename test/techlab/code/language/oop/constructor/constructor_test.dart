import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('no args', () {
    const s1 = '\n'
        'class Person {\n'
        '  Person() {}\n'
        '}\n';

    const s2 = '\n'
        'class Person {\n'
        '  constructor() {}\n'
        '}\n'
        '';

    const s3 = '\n'
        'class Person {\n'
        '  Person() {}\n'
        '}\n';

    const s4 = '\n'
        'class Person {\n'
        '  Person() {}\n'
        '}\n'
        '';

    oopRunAndExpect(
      CodeClass.of(
        name: 'person',
        constructors: CodeConstructor.of(
          body: [],
        ),
      ),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s4,
    );
  });

  group('args', () {
    const s1 = '\n'
        'class Person {\n'
        '  /// Just a sample\n'
        '  Person(String firstName = \'john doe\') {}\n'
        '}\n';

    const s2 = '\n'
        'class Person {\n'
        '  /**\n'
        '   * Just a sample\n'
        '   */\n'
        '  constructor(firstName: string = \'john doe\') {}\n'
        '}\n'
        '';

    const s3 = '\n'
        'class Person {\n'
        '  /**\n'
        '   * Just a sample\n'
        '   */\n'
        '  public Person(String firstName = "john doe") {}\n'
        '}\n';

    const s4 = '\n'
        'class Person {\n'
        '  /**\n'
        '   * Just a sample\n'
        '   */\n'
        '  public Person(firstName: String = "john doe") {}\n'
        '}\n'
        '';

    oopRunAndExpect(
      CodeClass.of(
        name: 'person',
        constructors: CodeConstructor.of(
          comment: 'Just a sample',
          public: true,
          requiredArgs: [
            ['first name', 'string', 'john doe']
          ],
          body: [],
        ),
      ),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s4,
    );
  });
}
