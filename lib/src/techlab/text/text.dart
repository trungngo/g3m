part of g3.techlab;

abstract class Text implements Node {
  factory Text(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is String) {
      return parseNode<Text>(value, (v) => _RawText(v?.toString()));
    } else if (value is Text) {
      return value;
    } else {
      return TextTransform(value, StringFuncs.noop);
    }
  }

  @deprecated
  factory Text.of(dynamic value) {
    return Text(value);
  }

  factory Text.space([int count]) => _RawText(' ' * (count ?? 1));
}

/// The simple node that writes the specified [value] to the
/// ancestor's output sink.
///
class _RawText extends NoChildNode implements Text, Renderer {
  final String value;

  _RawText(this.value);

  @override
  void render(RenderContext context) {
    if (value == null) return;
    // Writes out the text as is.
    context.out.write(value);
  }
}

/// The simple node that writes a number of new line character, specified by
/// the [count] parameter to the ancestor's output sink. If [count] is not
/// specified, by default, just output 1 new line.
///
class NewLine extends NoChildNode implements Renderer {
  final int count;

  NewLine([this.count = 1])
      : assert(count > 0, 'count must be a positive number');

  @override
  void render(RenderContext context) {
    for (var line = 0; line < count; line++) {
      context.out.writeln();
    }
  }
}
