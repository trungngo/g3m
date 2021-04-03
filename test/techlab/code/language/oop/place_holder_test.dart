import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('no child', () {
    const s = '\n'
        '// region custom code of abc\n'
        '// endregion custom code of abc\n'
        '';
    oopRunAndExpect(
      CodePlaceHolder.of(name: 'abc'),
      dart: s,
      typescript: s,
      java: s,
      kotlin: s,
    );
  });

  group('with child', () {
    const s = '\n'
        '// region custom code of abc\n'
        '// hello world\n'
        '// endregion custom code of abc\n'
        '';
    oopRunAndExpect(
      CodePlaceHolder.of(name: 'abc', body: CodeComment.of('hello world')),
      dart: s,
      typescript: s,
      java: s,
      kotlin: s,
    );
  });
}
