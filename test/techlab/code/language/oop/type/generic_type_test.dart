import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('Single', () {
    oopRunAndExpect(
      CodeType.ofDynamic(),
      dart: 'dynamic',
      typescript: 'any',
      java: 'object',
      kotlin: 'Any',
    );
    oopRunAndExpect(
      CodeType.ofVoid(),
      dart: 'void',
      typescript: 'void',
      java: 'void',
      kotlin: 'void',
    );
    oopRunAndExpect(
      CodeType.ofBool(),
      dart: 'bool',
      typescript: 'boolean',
      java: 'boolean',
      kotlin: 'Boolean',
    );
    oopRunAndExpect(
      CodeType.ofChar(),
      dart: 'String',
      typescript: 'string',
      java: 'char',
      kotlin: 'Char',
    );
    oopRunAndExpect(
      CodeType.ofString(),
      dart: 'String',
      typescript: 'string',
      java: 'String',
      kotlin: 'String',
    );
    oopRunAndExpect(
      CodeType.ofByte(),
      dart: 'int',
      typescript: 'number',
      java: 'byte',
      kotlin: 'Byte',
    );
    oopRunAndExpect(
      CodeType.ofShort(),
      dart: 'int',
      typescript: 'number',
      java: 'short',
      kotlin: 'Short',
    );
    oopRunAndExpect(
      CodeType.ofInteger(),
      dart: 'int',
      typescript: 'number',
      java: 'int',
      kotlin: 'Int',
    );
    oopRunAndExpect(
      CodeType.ofLong(),
      dart: 'int',
      typescript: 'number',
      java: 'long',
      kotlin: 'Long',
    );
    oopRunAndExpect(
      CodeType.ofFloat(),
      dart: 'double',
      typescript: 'number',
      java: 'float',
      kotlin: 'Float',
    );
    oopRunAndExpect(
      CodeType.ofDouble(),
      dart: 'double',
      typescript: 'number',
      java: 'double',
      kotlin: 'Double',
    );
  });
}
