import 'package:g3m/stimpack_core.dart';
import 'package:g3m/stimpack_meta.dart';
import 'package:g3m/stimpack_meta_techlab.dart';
import 'package:g3m/stimpack_model.dart';
import 'package:g3m/stimpack_story.dart';
import 'package:test/test.dart';

void main() {
  final model = stimpack.model;
  final t = model.type, f = model.field;

  test('gen', () {
    final meta = model.package.of(name: 'db');
    final tTable = t.symbolOf(name: 'table', package: meta);

    final tDatabase = t.symbolOf(name: 'database', package: meta);
    final tColumn = t.symbolOf(name: 'column', package: meta);
    final tIndex = t.symbolOf(name: 'index', package: meta);

    tDatabase.fields = {
      f.of(name: 'tables', type: t.setOf(item: tTable)).required(),
    };

    tTable.fields = {
      f.of(name: 'columns', type: t.setOf(item: tColumn)).required(),
      f.of(name: 'indices', type: t.setOf(item: tIndex)),
    };

    expect(meta.types.length, equals(4));
    stimpackGen(meta, '/tmp/meta-test', values: {
      tTable: {'user', 'group'},
      t.story.actor: {'new actor'},
    });
  });
}
