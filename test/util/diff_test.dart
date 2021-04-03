import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:test/test.dart';

void assertEq(String expected, String s) {
  expect(s.toString(), equals(expected));
}

void main() {
  test('normal', () {
    final s1 = '''
Hello 
World    
    ''';
    final s2 = '''
Hello 
My
World    
    ''';

    final s3 = '''
Hello 
World    
!!!''';
    final s4 = '''
Hello 
My
World    
!!!''';

    final diffs = diff(s1, s2);
    assert(diffs != null);
    assert(diffs.length == 3);

    final patches = patchMake(s1, b: diffs);
    assert(patches != null);
    assert(patches.length == 1);

    final res2 = patchToText(patches);
    print(res2);
    assert(res2 != null);

    final result = patchApply(patches, s3);
    assert(result != null);
    assert(result.length == 2);

    final finalText = result[0] as String;
    print(finalText);
    assert(finalText != null);
    assert(finalText == s4);

    final success = result[1] as List<bool>;
    assert(success != null);
    assert(success.length == patches.length);
    assert(success[0]);
  });
}
