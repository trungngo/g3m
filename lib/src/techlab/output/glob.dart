part of g3.techlab;

abstract class GlobIgnoreNode implements Node {
  bool matches(String path);
}

class GlobIgnore implements GlobIgnoreNode {
  final Node _child;

  Iterable<bool Function(String path)> _matchers;

  String _dir;

  static bool isIgnored(BuildContext context, String path) {
    final globs = context.findAncestorNodesOfExactType<GlobIgnoreNode>();

    if (globs == null) return false;

    for (final glob in globs) {
      if (glob.matches(path) == true) return true;
    }

    return false;
  }

  factory GlobIgnore.fromText(String content, Node child) {
    // See: https://git-scm.com/docs/gitignore

    return GlobIgnore._([
      (path) {
        var matched = false;

        if (content != null) {
          final lines = content.split('\n');

          for (var line in lines) {
            line = line.trim();
            // '#' marks that the line is just a comment.
            if (line.isNotEmpty && !line.startsWith('#')) {
              var negated = false;
              if (line.startsWith('!')) {
                // This is a negate rule.
                line = line.substring(1).trim();
                negated = true;
              }

              final rule = glob.Glob(line);
              if (rule.matches(path)) {
                matched = !negated;
              }
            }
          }
        }

        return matched;
      }
    ], child);
  }

  GlobIgnore._(this._matchers, this._child);

  @override
  bool matches(String path) {
    if (path == null || _dir == null || _matchers?.isNotEmpty != true) {
      return false;
    }

    final dirRelativePath = ioPath.normalize(_dir) + '/';
    var relativePath = ioPath.normalize(path);

    if (!relativePath.startsWith(dirRelativePath)) return false;
    relativePath = relativePath.substring(dirRelativePath.length);

    for (final matcher in _matchers) {
      if (matcher(relativePath) == true) return true;
    }

    return false;
  }

  @override
  Node build(BuildContext context) {
    assert(context.dir != null);
    _dir = context.dir;
    return _child;
  }
}

class GlobIgnoreFile implements Node {
  /// The file name.
  final String name;
  final Node _child;

  GlobIgnoreFile(this.name, this._child) : assert(name != null);

  @override
  Node build(BuildContext context) {
    final path = ioPath.join(context.dir, name);
    final file = io.File(path);
    if (!file.existsSync()) return _child;

    final content = file.readAsStringSync();
    return GlobIgnore.fromText(content, _child);
  }
}
