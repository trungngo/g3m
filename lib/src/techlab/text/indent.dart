part of g3.techlab;

/// Defines indentation config for all descendents.
/// [Indent] can be used to indent child's output with this configuration.
///
class IndentConfig implements Node {
  /// True indicates that the code should use tab character for indentation.
  /// Otherwise, space will be used.
  final bool useTab;

  /// How many characters (tab or space) shall be used for indentation.
  final int size;

  final Node child;

  IndentConfig({
    this.size = 2,
    this.useTab = false,
    this.child,
  });

  IndentConfig.useSpace2(Node child)
      : size = 2,
        useTab = false,
        child = child;

  IndentConfig.useSpace4(Node child)
      : size = 4,
        useTab = false,
        child = child;

  IndentConfig.useTab(Node child)
      : size = 1,
        useTab = true,
        child = child;

  @override
  Node build(BuildContext context) {
    return child;
  }

  static IndentConfig of(BuildContext context) {
    return context.dependOnAncestorNodeOfExactType<IndentConfig>();
  }
}

class Indent implements Node {
  final int level;
  final Node child;

  Indent._(this.child, this.level)
      : assert(level > 0, 'level must be a positive number');

  factory Indent(dynamic child, {int level = 1}) =>
      Indent._(Node.of(child), level);

  static String compute(String s, bool useTab, size, int level) {
    if (level < 1) return s;
    var tab = useTab ? '\t' : ' ';
    tab *= size * level ?? 1;

    s = s.trimLeft();

    var lines = s.split('\n');
    lines = lines.map((e) {
      if (e.trim().isEmpty) return '';
      return '${tab}${e}';
    }).toList();

    s = lines.join('\n');
    return s.trimRight();
  }

  @override
  Node build(BuildContext context) {
    final config = IndentConfig.of(context);
    return TextTransform(child, (s) {
      return compute(s, config.useTab, config.size, level);
    });
  }
}
