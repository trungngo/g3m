import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('Single - dynamic', () {
    oopRunAndExpect(
      CodeType.ofDynamic(),
      dart: 'dynamic',
      typescript: 'any',
      java: 'object',
      kotlin: 'Any',
    );
  });
  group('Single - void', () {
    oopRunAndExpect(
      CodeType.ofVoid(),
      dart: 'void',
      typescript: 'void',
      java: 'void',
      kotlin: 'void',
    );
  });
  group('Single - bool', () {
    oopRunAndExpect(
      CodeType.ofBool(),
      dart: 'bool',
      typescript: 'boolean',
      java: 'boolean',
      kotlin: 'Boolean',
    );
  });
  group('Single - char', () {
    oopRunAndExpect(
      CodeType.ofChar(),
      dart: 'String',
      typescript: 'string',
      java: 'char',
      kotlin: 'Char',
    );
  });
  group('Single - string', () {
    oopRunAndExpect(
      CodeType.ofString(),
      dart: 'String',
      typescript: 'string',
      java: 'String',
      kotlin: 'String',
    );
  });
  group('Single - byte', () {
    oopRunAndExpect(
      CodeType.ofByte(),
      dart: 'int',
      typescript: 'number',
      java: 'byte',
      kotlin: 'Byte',
    );
  });
  group('Single - short', () {
    oopRunAndExpect(
      CodeType.ofShort(),
      dart: 'int',
      typescript: 'number',
      java: 'short',
      kotlin: 'Short',
    );
  });
  group('Single - integer', () {
    oopRunAndExpect(
      CodeType.ofInteger(),
      dart: 'int',
      typescript: 'number',
      java: 'int',
      kotlin: 'Int',
    );
  });
  group('Single - long', () {
    oopRunAndExpect(
      CodeType.ofLong(),
      dart: 'int',
      typescript: 'number',
      java: 'long',
      kotlin: 'Long',
    );
  });
  group('Single - float', () {
    oopRunAndExpect(
      CodeType.ofFloat(),
      dart: 'double',
      typescript: 'number',
      java: 'float',
      kotlin: 'Float',
    );
  });
  group('Single - double', () {
    oopRunAndExpect(
      CodeType.ofDouble(),
      dart: 'double',
      typescript: 'number',
      java: 'double',
      kotlin: 'Double',
    );
  });
}
