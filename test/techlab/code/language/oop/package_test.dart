import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('Single', () {
    oopRunAndExpect(
      CodePackage.of('hello'),
      kotlin: '\npackage hello',
    );
    oopRunAndExpect(
      CodePackage.of('hello world'),
      kotlin: '\npackage hello_world',
    );
  });

  group('With Path', () {
    oopRunAndExpect(
      CodePackage.of(
        'hello',
        path: ['org', 'example'],
      ),
      kotlin: '\npackage org.example.hello',
    );

    oopRunAndExpect(
      CodePackage.of(
        'hello',
        path: ['org', 'my example'],
      ),
      kotlin: '\npackage org.my_example.hello',
    );
  });
}
