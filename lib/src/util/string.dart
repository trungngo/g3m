part of g3.util;

typedef StringFunc = String Function(String s);

final _normalizeExpr = RegExp('\\s+');

class StringFuncs {
  /// Normalizes a string to non trailing/leading spaces. Also,
  /// there is no double spaces.
  ///
  static final StringFunc norm =
      (s) => s?.trim()?.replaceAll(_normalizeExpr, ' ');

  static final StringFunc noop = (s) => s;
  static final StringFunc ignore = (s) => '';

  static final StringFunc upper = noEmpty((s) => s.toUpperCase());
  static final StringFunc lower = noEmpty((s) => s.toLowerCase());
  static final StringFunc camel = noEmpty((s) => ReCase.forCode(s).camel);
  static final StringFunc pascal = noEmpty((s) => ReCase.forCode(s).pascal);
  static final StringFunc snake = noEmpty((s) => ReCase.forCode(s).snake);
  static final StringFunc dot = noEmpty((s) => ReCase.forCode(s).dot);
  static final StringFunc path = noEmpty((s) => ReCase.forCode(s).path);
  static final StringFunc param = noEmpty((s) => ReCase.forCode(s).param);
  static final StringFunc header = noEmpty((s) => ReCase.forCode(s).header);
  static final StringFunc title = noEmpty((s) => ReCase.forCode(s).title);
  static final StringFunc constant = noEmpty((s) => ReCase.forCode(s).constant);
  static final StringFunc sentence = noEmpty((s) => ReCase.forCode(s).sentence);

  static final StringFunc singleQuotes =
      noEmpty((s) => '\'${s.replaceAll('\'', '\\\'')}\'');

  static final StringFunc doubleQuotes =
      noEmpty((s) => '"${s.replaceAll('"', '\\"')}"');

  static final StringFunc plural = noEmpty((s) => inflection.pluralize(s));
  static final StringFunc singular = noEmpty((s) => inflection.singularize(s));
  static final StringFunc past = noEmpty((s) => inflection.past(s));

  static StringFunc noEmpty(StringFunc func) =>
      (s) => s != null && s.isNotEmpty ? func(s) : s;

  /// Lazy init the code func.
  static CodeFunc _code;

  static CodeFunc get code => _code ??= CodeFunc._();

  static MarkdownFunc _markdown;

  static MarkdownFunc get markdown => _markdown ??= MarkdownFunc._();
}

class CodeFunc {
  StringFunc commentJavaDoc;
  StringFunc commentDoubleSplash;
  StringFunc commentTripleSplash;
  StringFunc commentXml;
  StringFunc commentHash;
  StringFunc parenthesis;
  StringFunc curlyBracket;
  StringFunc bracket;

  StringFunc underscorePrefix;

  StringFunc prefix(String ch) => (s) => ch + s;

  StringFunc suffix(String ch) => (s) => ch + s;

  StringFunc _comment(String ch) => (s) => ch + s.split('\n').join('\n$ch');

  CodeFunc._() {
    commentHash = _comment('# ');
    commentDoubleSplash = _comment('// ');
    commentTripleSplash = _comment('/// ');
    commentJavaDoc = (s) => '/**\n * ' + s.split('\n').join('\n * ') + '\n */';
    commentXml = (s) => '<!-- \n * ' + s.split('\n').join('\n    ') + '\n */ -->';
    parenthesis = (s) => '($s)';
    curlyBracket = (s) => '{$s}';
    bracket = (s) => '[$s]';
    underscorePrefix = prefix('_');
  }
}

class MarkdownFunc {
  final StringFunc h1 = (s) => h(1, s);
  final StringFunc h2 = (s) => h(2, s);
  final StringFunc h3 = (s) => h(3, s);
  final StringFunc h4 = (s) => h(4, s);
  final StringFunc h5 = (s) => h(5, s);
  final StringFunc h6 = (s) => h(6, s);

  static String h(int level, String s) {
    if (level > 6) level = 6;
    return s?.isNotEmpty == true ? '#' * level + ' ' + s : s;
  }

  final StringFunc bold = (s) => s?.isNotEmpty == true ? '**$s**' : s;
  final StringFunc italic = (s) => s?.isNotEmpty == true ? '*$s*' : s;
  final StringFunc code = (s) => s?.isNotEmpty == true ? '`$s`' : s;

  final String rule = '---';

  StringFunc link([String title]) {
    return (url) => title == null ? '<$url>' : '[$title]($url)';
  }

  StringFunc image([String text, String title]) {
    title = title == null ? '' : ' ' + title;
    return (url) => '![$text]($url$title)';
  }

  final StringFunc email = (s) => '<$s>';

  MarkdownFunc._();
}

extension G3StringExtension on String {
  String removeIfStartsWith(String prefix) {
    if (startsWith(prefix)) {
      return substring(prefix.length);
    }

    return this;
  }

  String past() => inflection.past(this);

  String pluralize() => inflection.pluralize(this);

  String singularize() => inflection.singularize(this);
}
