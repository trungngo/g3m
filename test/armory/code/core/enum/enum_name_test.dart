import 'package:g3m/g3armory.dart';
import 'package:g3m/g3armory_java.dart';
import 'package:test/test.dart';

import '../../../utils.dart';

void main() {
  test('empty', () {
    run(
      CodeEnumName.of(name: ''),
      '',
    );
  });

  test('string', () {
    run(
      CodeEnumName.of(name: 'hello world'),
      'HelloWorld',
    );
  });

  test('node', () {
    run(
      CodeEnumName.of(name: Text.of('hello world')),
      'HelloWorld',
    );
  });

  test('name of another name', () {
    // Runs with dart config
    var argName = CodeArgName.of(name: 'hello world');
    run(argName, 'helloWorld');
    run(
      CodeEnumName.of(name: argName),
      'HelloWorld',
    );
  });
}

void run(Node node, String expected) {
  var code = JavaCodeConfig(node);
  runAndExpect(code, expected);
}