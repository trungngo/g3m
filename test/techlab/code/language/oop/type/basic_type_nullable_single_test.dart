import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  group('Generic', () {
    const s1 = 'MyFord<MyCar>';
    oopRunAndExpect(
      CodeType.of(name: 'my ford', generic: 'my car'),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('Generic - 2 Params', () {
    const s1 = 'MyFord<MyCar, MyTank>';
    oopRunAndExpect(
      CodeType.of(name: 'my ford', generic: ['my car', 'my tank']),
      dart: s1,
      typescript: s1,
      java: s1,
      kotlin: s1,
    );
  });

  group('Generic - 2 Params, Array', () {
    const s1 = 'MyFord<MyCar, MyTank>[]';
    const s2 = 'List<MyFord<MyCar, MyTank>>';
    const s3 = 'Array<MyFord<MyCar, MyTank>>';
    oopRunAndExpect(
      CodeType.of(name: 'my ford', generic: ['my car', 'my tank'], array: true),
      dart: s2,
      typescript: s1,
      java: s1,
      kotlin: s3,
    );
  });
}
