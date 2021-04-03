import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('by string transform', () {
    group('double splash', () {
      var code = CodeCommentConfig.doubleSplash(
        CodeComment.of('hello\nworld'),
      );
      oopRunAndExpect(
        code,
        java: '// hello\n'
            '// world\n',
      );
    });

    group('triple splash', () {
      var code = CodeCommentConfig.tripleSplash(
        CodeComment.of('hello\nworld'),
      );
      oopRunAndExpect(
        code,
        java: '/// hello\n'
            '/// world\n',
      );
    });

    group('hash', () {
      var code = CodeCommentConfig.hash(
        CodeComment.of('hello\nworld'),
      );
      oopRunAndExpect(
        code,
        java: '# hello\n'
            '# world\n',
      );
    });

    group('java doc', () {
      var code = CodeCommentConfig.javaDoc(
        CodeComment.of('hello\nworld'),
      );
      oopRunAndExpect(
        code,
        java: '/**\n'
            ' * hello\n'
            ' * world\n'
            ' */\n',
      );
    });
  });

  group('by code config', () {
    group('function', () {

      oopRunAndExpect(
        CodeFunction.of(
          name: 'world',
          comment: 'hello',
        ),
        dart: '\n'
            '/// hello\n'
            'void world()',
        typescript: '\n'
            '/**\n'
            ' * hello\n'
            ' */\n'
            'world(): void',
        java: '\n'
            '/**\n'
            ' * hello\n'
            ' */\n'
            'void world()',
        kotlin: '\n'
            '/**\n'
            ' * hello\n'
            ' */\n'
            'fun world()',
      );
    });

    group('class', () {
      oopRunAndExpect(
        CodeClass.of(
          name: 'world',
          comment: 'hello',
        ),
        dart: '\n'
            '/// hello\n'
            'class World {\n'
            '\n'
            '}\n',
        typescript: '\n'
            '/**\n'
            ' * hello\n'
            ' */\n'
            'class World {\n'
            '\n'
            '}\n',
        java: '\n'
            '/**\n'
            ' * hello\n'
            ' */\n'
            'class World {\n'
            '\n'
            '}\n',
        kotlin: '\n'
            '/**\n'
            ' * hello\n'
            ' */\n'
            'class World {\n'
            '\n'
            '}\n',
      );
    });
  });
}
