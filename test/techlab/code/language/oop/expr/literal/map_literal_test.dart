import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void main() {
  group('null', () {
    const s1 = 'null';
    oopRunAndExpect(
      CodeMapLiteral.of(null),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('empty map', () {
    const s1 = '{}';
    oopRunAndExpect(
      CodeMapLiteral.of({}),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('non empty map', () {
    const s2 = '{\n'
        '  "bool": true,\n'
        '  "name": null,\n'
        '  "string": "A"\n'
        '}';
    var s1 = s2.replaceAll('"', '\'');
    oopRunAndExpect(
      CodeMapLiteral.of({
        'bool': true,
        'name': null,
        'string': 'A',
      }),
      dart: s1,
      typescript: s1,
      java: s2,
      kotlin: s2,
    );
  });

  group('nested object', () {
    const s2 = '{\n'
        '  "name": "john",\n'
        '  "age": 20,\n'
        '  "male": true,\n'
        '  "node": anyThing,\n'
        '  "array": [\n'
        '    1,\n'
        '    null,\n'
        '    "hello"\n'
        '  ],\n'
        '  "object": {\n'
        '    "name": "mary",\n'
        '    "age": 1,\n'
        '    "male": "false",\n'
        '    "array": [\n'
        '      10,\n'
        '      null,\n'
        '      "hello"\n'
        '    ]\n'
        '  }\n'
        '}';

    var s1 = s2.replaceAll('"', '\'');

    oopRunAndExpect(
      CodeMapLiteral.of({
        'name': 'john',
        'age': 20,
        'male': true,
        'node': Text('anyThing'),
        'array': [1, null, 'hello'],
        'object': {
          'name': 'mary',
          'age': 1,
          'male': 'false',
          'array': [10, null, 'hello'],
        }
      }),
      dart: s1,
      typescript: s1,
      java: s2,
      kotlin: s2,
    );
  });
}
