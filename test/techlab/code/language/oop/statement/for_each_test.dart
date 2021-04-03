import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('simple', () {
    const s1 = 'for (int i in entries) {}\n';

    const s2 = 'for (let i: number in entries) {}\n';

    const s3 = 'for (int i: entries) {}\n';

    const s4 = 'for (i in entries) {}\n';

    oopRunAndExpect(
      CodeForEach.of(
        item: CodeVar.of(name: 'i', type: CodeType.ofInteger()),
        collection: Text('entries'),
        body: [],
      ),
      dart: s1,
      typescript: s2,
      java: s3,
      kotlin: s4,
    );
  });
}
