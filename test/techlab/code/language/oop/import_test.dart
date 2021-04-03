import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('Import Package', () {
    oopRunAndExpect(
      // dart & typescript language prefers `path` instead of package; however,
      // use package still works.
      CodeImport.of(package: 'human'),
      dart: 'import \'human\'',
      typescript: 'import * from \'human\'',
      java: 'import human.*',
      kotlin: 'import human.*',
    );
  });

  group('Import Path', () {
    oopRunAndExpect(
      // java & kotlin language prefers `package` instead of path; however,
      // use path still works.
      CodeImport.of(path: 'human'),
      dart: 'import \'human\'',
      typescript: 'import * from \'human\'',
      java: 'import human.*',
      kotlin: 'import human.*',
    );
  });

  group('Import Types', () {
    oopRunAndExpect(
      CodeImport.of(package: 'my factory', types: [
        CodeImportType.of(type: 'my vehicle'),
        CodeImportType.of(type: 'my bike'),
      ]),

      // dart dont allow import types
      dart: 'import \'my_factory\'',
      typescript: 'import { MyVehicle , MyBike } from \'myFactory\'',
      // FIXME might need to put a comma etc.
      java: 'import my_factory.MyVehicle'
          'import my_factory.MyBike',
      kotlin: 'import my_factory.MyVehicle'
          'import my_factory.MyBike',
    );
  });
}
