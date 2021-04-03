import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('Array', () {
    oopRunAndExpect(
      CodeType.arrayOfDynamic(),
      dart: 'List<dynamic>',
      typescript: 'any[]',
      java: 'object[]',
      kotlin: 'Array<Any>',
    );

    oopRunAndExpect(
      CodeType.arrayOfBool(),
      dart: 'List<bool>',
      typescript: 'boolean[]',
      java: 'boolean[]',
      kotlin: 'Array<Boolean>',
    );

    oopRunAndExpect(
      CodeType.arrayOfChar(),
      dart: 'List<String>',
      typescript: 'string[]',
      java: 'char[]',
      kotlin: 'Array<Char>',
    );
    oopRunAndExpect(
      CodeType.arrayOfString(),
      dart: 'List<String>',
      typescript: 'string[]',
      java: 'String[]',
      kotlin: 'Array<String>',
    );
    oopRunAndExpect(
      CodeType.arrayOfByte(),
      dart: 'List<int>',
      typescript: 'number[]',
      java: 'byte[]',
      kotlin: 'Array<Byte>',
    );
    oopRunAndExpect(
      CodeType.arrayOfShort(),
      dart: 'List<int>',
      typescript: 'number[]',
      java: 'short[]',
      kotlin: 'Array<Short>',
    );
    oopRunAndExpect(
      CodeType.arrayOfInteger(),
      dart: 'List<int>',
      typescript: 'number[]',
      java: 'int[]',
      kotlin: 'Array<Int>',
    );
    oopRunAndExpect(
      CodeType.arrayOfLong(),
      dart: 'List<int>',
      typescript: 'number[]',
      java: 'long[]',
      kotlin: 'Array<Long>',
    );
    oopRunAndExpect(
      CodeType.arrayOfFloat(),
      dart: 'List<double>',
      typescript: 'number[]',
      java: 'float[]',
      kotlin: 'Array<Float>',
    );
    oopRunAndExpect(
      CodeType.arrayOfDouble(),
      dart: 'List<double>',
      typescript: 'number[]',
      java: 'double[]',
      kotlin: 'Array<Double>',
    );
  });
}
