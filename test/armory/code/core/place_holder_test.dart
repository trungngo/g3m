import 'package:g3m/g3armory.dart';
import 'package:g3m/g3armory_java.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void main() {
  void run(Node node, String expected) {
    var code = JavaCodeConfig(node);
    runAndExpect(code, expected);
  }

  test('no child', () {
    run(
      CodePlaceHolder.of(name: 'abc'),
      '\n'
      '// region custom code of abc\n'
      '// endregion custom code of abc\n'
      '',
    );
  });

  test('with child', () {
    run(
      CodePlaceHolder.of(name: 'abc', body: CodeComment.of('hello world')),
      '\n'
      '// region custom code of abc\n'
      '// hello world\n'
      '// endregion custom code of abc\n'
      '',
    );
  });
}
