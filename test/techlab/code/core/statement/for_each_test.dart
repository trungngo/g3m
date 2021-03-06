import 'package:g3m/techlab_core.dart';
import 'package:g3m/techlab_java.dart';
import 'package:test/test.dart';

import '../../../utils.dart';

void main() {
  test('simple', () {
    var code = JavaCodeConfig(
      CodeForEach.of(
        item: CodeVar.of(name: 'i', type: 'int'),
        collection: Text('entries'),
        body: ['print("Hello World!");'],
      ),
    );

    runAndExpect(
      code,
      'for (int i: entries) {\n'
      '  print("Hello World!");\n'
      '}\n',
    );
  });
}
