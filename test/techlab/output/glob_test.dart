import 'package:g3m/techlab_core.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  test('Just ignore any absolute path that is not in the context path', () {
    final root = GlobIgnore.fromText(
      '**',
      GlobTestNode(
        count: 1,
        no: [
          '',
          '/',
          '/abc.txt',
        ],
      ),
    );
    runAndExpect(root, 'ok');
  });

  test('Just match everything', () {
    final root = GlobIgnore.fromText(
      '**',
      GlobTestNode(
        count: 1,
        yes: [
          'a.txt',
          'a/b.txt',
          'a/b/c.txt',
        ],
      ),
    );
    runAndExpect(root, 'ok');
  });

  test('Just match any file, no sub files', () {
    final root = GlobIgnore.fromText(
      '*',
      GlobTestNode(
        count: 1,
        yes: [
          'a.txt',
        ],
        no: [
          'a/b.txt',
          'a/b/c.txt',
        ],
      ),
    );
    runAndExpect(root, 'ok');
  });

  test('Just match any txt, no other file types', () {
    final root = GlobIgnore.fromText(
      '**.txt',
      GlobTestNode(
        count: 1,
        yes: [
          'a.txt',
          'a/b.txt',
          'a/b/c.txt',
        ],
        no: [
          'a.dart',
          'a/b.dart',
          'a/b/c.dart',
        ],
      ),
    );
    runAndExpect(root, 'ok');
  });

  test('Just first match', () {
    final root = GlobIgnore.fromText(
      '''
# just a comment
abc.dart
**.txt
**.java
''',
      GlobFirstMatchTestNode(
        yes: [
          'a.txt',
          'a/b.txt',
          'a/b/c.txt',
          'abc.dart',
          'a/b/c.java',
        ],
        no: [
          'a.dart',
          'a/b.dart',
          'a/b/c.dart',
        ],
      ),
    );
    runAndExpect(root, 'ok');
  });
}

class GlobFirstMatchTestNode extends NoChildNode {
  final Iterable<String> yes;
  final Iterable<String> no;
  final Iterable<String> ignored;

  GlobFirstMatchTestNode({this.yes, this.no, this.ignored});

  @override
  Node build(BuildContext context) {
    final dir = context.dir;

    if (yes != null) {
      for (final s in yes) {
        assert(GlobIgnore.isIgnored(context, join(dir, s)), 'fail: $s');
      }
    }
    if (no != null) {
      for (final s in no) {
        assert(!GlobIgnore.isIgnored(context, join(dir, s)), 'fail: $s');
      }
    }
    return Text('ok');
  }
}

class GlobTestNode extends NoChildNode {
  final int count;
  final Iterable<String> yes;
  final Iterable<String> no;
  final Iterable<String> ignored;

  GlobTestNode({this.count, this.yes, this.no, this.ignored});

  @override
  Node build(BuildContext context) {
    final globs = context.findAncestorNodesOfExactType<GlobIgnore>();
    assert(globs.length == count);

    final dir = context.dir;

    for (final glob in globs) {
      if (yes != null) {
        for (final s in yes) {
          assert(glob.matches(join(dir, s)), 'fail: $s');
        }
      }
      if (no != null) {
        for (final s in no) {
          assert(!glob.matches(join(dir, s)), 'fail: $s');
        }
      }
    }
    return Text('ok');
  }
}
