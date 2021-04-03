import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('simple', () {
    const s1 = 'for (Int i = 0; i<10; i++) {}\n';

    const s2 = 'for (let i: Int = 0; i<10; i++) {}\n';

    const s4 = 'for (var i: Int = 0; i<10; i++) {}\n';

    oopRunAndExpect(
      CodeFor.of(
        init: CodeVar.of(name: 'i', type: 'int', init: 0),
        condition: Text('i<10'),
        step: Text('i++'),
        body: [],
      ),
      dart: s1,
      typescript: s2,
      java: s1,
      kotlin: s4,
    );
  });
}
