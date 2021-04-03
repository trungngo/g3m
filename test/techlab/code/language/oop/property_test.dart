import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('simple', () {
    var code = CodeProperty.of(
      name: 'first name',
      type: 'string',
      isPrivate: true,
      isOverride: true,
      getter: CodePropertyGetter.of(
        comment: 'Just a getter comment',
        body: CodeReturn.of('john'),
      ),
      setter: CodePropertySetter.of(
        comment: 'Just a setter comment',
        body: CodeComment.of('TODO'),
      ),
    );

    // https://www.geeksforgeeks.org/dart-getters-and-setters/
    const s1 = '\n'
        '/// Just a getter comment\n'
        '@override\n'
        'String get _firstName {\n'
        '  return \'john\';\n'
        '}\n'
        '\n'
        '/// Just a setter comment\n'
        '@override\n'
        'set _firstName(String value) {\n'
        '  // TODO\n'
        '}';

    // https://www.typescripttutorial.net/typescript-tutorial/typescript-getters-setters/
    const s2 = '\n'
        '/**\n'
        ' * Just a getter comment\n'
        ' */\n'
        '@override\n'
        'private get firstName(): string {\n'
        '  return \'john\';\n'
        '}\n'
        '\n'
        '/**\n'
        ' * Just a setter comment\n'
        ' */\n'
        '@override\n'
        'private set firstName(value: string) {\n'
        '  // TODO\n'
        '}';

    const s3 = '\n'
        '/**\n'
        ' * Just a getter comment\n'
        ' */\n'
        '@override\n'
        'private String getFirstName() {\n'
        '  return "john";\n'
        '}\n'
        '\n'
        '/**\n'
        ' * Just a setter comment\n'
        ' */\n'
        'private set firstName(String value) {\n'
        '  // TODO\n'
        '}';

    // https://kotlinlang.org/docs/reference/properties.html
    const s4 = '\n'
        'var firstName: String\n'
        '  /**\n'
        '   * Just a getter comment\n'
        '   */\n'
        '  @override\n'
        '  get() {\n'
        '    return "john";\n'
        '  }\n'
        '\n'
        '  /**\n'
        '   * Just a setter comment\n'
        '   */\n'
        '  @override\n'
        '  set(value) {\n'
        '    // TODO\n'
        '  }';

    oopRunAndExpect(
      code,
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s4,
    );
  });
}
