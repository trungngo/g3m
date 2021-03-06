import 'package:g3m/techlab_core.dart';
import 'package:g3m/techlab_typescript.dart';
import 'package:test/test.dart';

import '../../../utils.dart';

void main() {
  test('all', () {
    var root = TypescriptCode.of(
      body: Text('// You can put anything in this body.'),
      comment: CodeComment.of('Demo file level comment'),
      imports: [
        CodeImport.of(path: 'io'),
        CodeImport.of(path: 'path', alias: 'ioPath'),
        CodeImport.of(path: 'math', types: [
          CodeImportType.of(type: 'vector', alias: 'MyVector'),
          CodeImportType.of(type: 'human matrix'),
        ]),
      ],
      enums: [
        CodeEnum.of(
          name: 'color',
          values: ['blue', 'dark green'],
        ),
      ],
      functions: [
        CodeFunction.of(
          name: 'hello',
          isAsync: true,
          requiredArgs: [
            ['first name', 'string'],
          ],
          body: [
            Text('var name = "John";\n'
                'print(name);\n'),
          ],
        ),
      ],
      interfaces: [
        CodeInterface.of(
          name: 'car',
          isPrivate: true,
          extend: 'vehicle',
          fields: [
            ['name', 'string'],
            CodeField.of(
              name: 'last name',
              type: 'string',
              isOptional: true,
            ),
          ],
        ),
      ],
      classes: [
        clazz(),
      ],
    );
    runAndExpect(
      root,
      '// Demo file level comment\n'
      '\n'
      '\n'
      'import * from \'io\';\n'
      'import * as ioPath from \'path\';\n'
      'import { Vector as MyVector , HumanMatrix } from \'math\';\n'
      '\n'
      '\n'
      'enum Color {\n'
      '  Blue,\n'
      '  DarkGreen\n'
      '}\n'
      '\n'
      '\n'
      'async hello(firstName: string) {\n'
      '  var name = "John";\n'
      '  print(name);\n'
      '}\n'
      '\n'
      '\n'
      'private interface Car extends Vehicle {\n'
      '  name: string;\n'
      '\n'
      '  lastName?: string;\n'
      '}\n'
      '\n'
      '\n'
      '\n'
      'export abstract class Person<T> {\n'
      '  // The human first name.\n'
      '  firstName: string;\n'
      '\n'
      '  age?: number;\n'
      '\n'
      '\n'
      '  /**\n'
      '   * a demo constructor\n'
      '   */\n'
      '  constructor(name: string, age?: number) {\n'
      '    // Any free text can be here\n'
      '  }\n'
      '\n'
      '\n'
      '  /**\n'
      '   * just a demo function\n'
      '   */\n'
      '  drive<T>(vehicle, car): void {\n'
      '    // Just any text\n'
      '  }\n'
      '  // just a free text class body \n'
      '  // with Mustache template support.\n'
      '  hello(John Doe);\n'
      '}\n'
      '// You can put anything in this body.',
    );
  });
}

CodeInterface interfaze() {
  return CodeInterface.of(
    name: 'person',
    isPublic: true,
    isAbstract: true,
    generic: [
      genericParam(),
    ],
    extend: [
      CodeType.of(name: 'human'),
    ],
    fields: [
      field(),
    ],
    functions: [
      function(),
    ],
    body: Mustache.template(
      '\n'
      '// just a free text class body \n'
      '// with Mustache template support.\n'
      'hello({{name}});',
      values: {'name': 'John Doe'},
    ),
  );
}

CodeGenericParam genericParam() => CodeGenericParam.of(name: 'T');

CodeClass clazz() {
  return CodeClass.of(
    name: 'person',
    isPublic: true,
    isAbstract: true,
    generic: [CodeGenericParam.of(name: 'T')],
    extend: null,
    implements: null,
    fields: [
      field(),
      CodeField.of(name: 'age', type: 'number', isOptional: true),
    ],
    constructors: [
      CodeConstructor.of(
          comment: 'a demo constructor',
          requiredArgs: [
            ['name', 'string'],
            CodeArg.of(name: 'age', type: 'number', isOptional: true),
          ],
          body: Container(['// Any free text can be here'])),
    ],
    functions: [
      function(),
    ],
    body: Mustache.template(
      '\n'
      '// just a free text class body \n'
      '// with Mustache template support.\n'
      'hello({{name}});',
      values: {'name': 'John Doe'},
    ),
  );
}

CodeFunction function() {
  return CodeFunction.of(
      name: 'drive',
      generic: ['T'],
      requiredArgs: ['vehicle', 'car'],
      comment: 'just a demo function',
      returns: ['void'],
      throws: ['accident exception', 'bad driver exception'],
      body: [
        Text('// Just any text'),
      ]);
}

CodeField field() {
  return CodeField.of(
    name: 'first name',
    type: 'string',
    comment: 'The human first name.',
  );
}
