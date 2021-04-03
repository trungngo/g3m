import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {

  group('List - dynamic', () {
    oopRunAndExpect(
      CodeType.listOfDynamic(),
      dart: 'List<dynamic>',
      typescript: 'List<any>',
      java: 'List<object>',
      kotlin: 'List<Any>',
    );
  });

  group('List', () {
    oopRunAndExpect(
      CodeType.listOfBool(),
      dart: 'List<bool>',
      typescript: 'List<boolean>',
      java: 'List<boolean>',
      kotlin: 'List<Boolean>',
    );
  });

  group('List', () {
    oopRunAndExpect(
      CodeType.listOfChar(),
      dart: 'List<String>',
      typescript: 'List<string>',
      java: 'List<char>',
      kotlin: 'List<Char>',
    );
  });

  group('List - string', () {
    oopRunAndExpect(
      CodeType.listOfString(),
      dart: 'List<String>',
      typescript: 'List<string>',
      java: 'List<String>',
      kotlin: 'List<String>',
    );
  });

  group('List - byte', () {
    oopRunAndExpect(
      CodeType.listOfByte(),
      dart: 'List<int>',
      typescript: 'List<number>',
      java: 'List<byte>',
      kotlin: 'List<Byte>',
    );
  });

  group('List short', () {
    oopRunAndExpect(
      CodeType.listOfShort(),
      dart: 'List<int>',
      typescript: 'List<number>',
      java: 'List<short>',
      kotlin: 'List<Short>',
    );
  });

  group('List - Integer', () {
    oopRunAndExpect(
      CodeType.listOfInteger(),
      dart: 'List<int>',
      typescript: 'List<number>',
      java: 'List<int>',
      kotlin: 'List<Int>',
    );
  });

  group('List - Long', () {
    oopRunAndExpect(
      CodeType.listOfLong(),
      dart: 'List<int>',
      typescript: 'List<number>',
      java: 'List<long>',
      kotlin: 'List<Long>',
    );
  });

  group('List - Float', () {
    oopRunAndExpect(
      CodeType.listOfFloat(),
      dart: 'List<double>',
      typescript: 'List<number>',
      java: 'List<float>',
      kotlin: 'List<Float>',
    );
  });

  group('List - Double', () {
    oopRunAndExpect(
      CodeType.listOfDouble(),
      dart: 'List<double>',
      typescript: 'List<number>',
      java: 'List<double>',
      kotlin: 'List<Double>',
    );
  });
}
