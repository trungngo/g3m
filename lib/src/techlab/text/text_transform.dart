part of g3.techlab;

/// The general purpose node that transform all the output
/// produced by its child using the specified [transform] function.
///
/// Please checkout other commonly used case sensitive transform nodes: [UpperCase],
/// [LowerCase], [PascalCase], [CamelCase], [SnakeCase], [PathCase]
/// [DotCase], [ParamCase], [HeaderCase], [TitleCase], [ConstantCase],
/// [SentenceCase].
///
class TextTransform implements Text, Renderer, PostRenderer {
  final Node content;
  final StringFunc transform;

  TextTransform._(this.content, this.transform);

  factory TextTransform(dynamic content, StringFunc transform) {
    return TextTransform._(Node.of(content), transform);
  }


  @override
  Node build(BuildContext context) {
    return content;
  }

  StringSink _old;
  StringBuffer _buffer;

  @override
  void render(RenderContext context) {
    _buffer = StringBuffer();
    _old = context.out;
    context.out = _buffer;
  }

  @override
  void postRender(RenderContext context) {
    var s = _buffer.toString();
    s = transform(s);
    context.out = _old;
    context.out.write(s);
  }
}

class UpperCase extends TextTransform {
  UpperCase(dynamic content) : super._(Node.of(content), StringFuncs.upper);
}

class LowerCase extends SingleChildNode {
  LowerCase(dynamic content)
      : super(TextTransform(
          content,
          StringFuncs.lower,
        ));
}

class PascalCase extends SingleChildNode {
  PascalCase(dynamic content)
      : super(TextTransform(
          content,
          StringFuncs.pascal,
        ));
}

class CamelCase extends SingleChildNode {
  CamelCase(dynamic content)
      : super(TextTransform(
          content,
          StringFuncs.camel,
        ));
}

class SnakeCase extends SingleChildNode {
  SnakeCase(dynamic content)
      : super(TextTransform(
          content,
          StringFuncs.snake,
        ));
}

class PathCase extends SingleChildNode {
  PathCase(dynamic content)
      : super(TextTransform(
          content,
          StringFuncs.path,
        ));
}

class DotCase extends SingleChildNode {
  DotCase(dynamic content)
      : super(TextTransform(
          content,
          StringFuncs.dot,
        ));
}

class ParamCase extends SingleChildNode {
  ParamCase(dynamic content)
      : super(TextTransform(
          content,
          StringFuncs.param,
        ));
}

class HeaderCase extends SingleChildNode {
  HeaderCase(dynamic content)
      : super(TextTransform(
          content,
          StringFuncs.header,
        ));
}

class TitleCase extends SingleChildNode {
  TitleCase(dynamic content)
      : super(TextTransform(
          content,
          StringFuncs.title,
        ));
}

class ConstantCase extends SingleChildNode {
  ConstantCase(dynamic content)
      : super(TextTransform(
          content,
          StringFuncs.constant,
        ));
}

class SentenceCase extends SingleChildNode {
  SentenceCase(dynamic content)
      : super(TextTransform(
          content,
          StringFuncs.sentence,
        ));
}
