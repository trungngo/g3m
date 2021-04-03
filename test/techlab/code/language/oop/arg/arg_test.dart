import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('simple', () {
    const s1 = 'Car myCar';
    const s2 = 'myCar: Car';

    oopRunAndExpect(
      CodeArg.of(
        name: 'my car',
        type: 'car',
      ),
      dart: s1,
      typescript: s2,
      java: s1,
      kotlin: s2,
    );
  });

  group('with init', () {
    oopRunAndExpect(
      CodeArg.of(
        name: 'name',
        type: 'String',
        init: 'john doe',
      ),
      dart: 'String name = \'john doe\'',
      typescript: 'name: string = \'john doe\'',
      java: 'String name = "john doe"',
      kotlin: 'name: String = "john doe"',
    );
  });

  group('with annotation', () {
    const s1 = 'Car myCar, @required\n@nonNull()\nCar another';
    const s2 = 'myCar: Car, @required\n@nonNull()\nanother: Car';

    oopRunAndExpect(
      CodeArgList.of(required: [
        ['my car', 'car'],
        CodeArg.of(
          name: 'another',
          type: 'car',
          annotations: [
            'required',
            CodeAnnotation.functionCall(name: 'non null'),
          ],
        ),
      ]),
      dart: s1,
      typescript: s2,
      java: s1,
      kotlin: s2,
    );
  });
}
