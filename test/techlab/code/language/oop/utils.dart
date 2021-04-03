import 'package:g3m/techlab_core.dart';
import 'package:g3m/techlab_dart.dart';
import 'package:g3m/techlab_java.dart';
import 'package:g3m/techlab_kotlin.dart';
import 'package:g3m/techlab_typescript.dart';
import 'package:test/test.dart';

import '../../../utils.dart';

void oopRunAndExpect(
  Node node, {
  String kotlin,
  String java,
  String dart,
  String typescript,
}) {
  if (dart != null) {
    test('dart', () {
      runAndExpect(DartCodeConfig(node), dart, 'language: dart');
    });
  }

  if (typescript != null) {
    test('typescript', () {
      runAndExpect(
          TypescriptCodeConfig(node), typescript, 'language: typescript');
    });
  }
  if (java != null) {
    test('java', () {
      runAndExpect(JavaCodeConfig(node), java, 'language: java');
    });
  }
  if (kotlin != null) {
    test('kotlin', () {
      runAndExpect(KotlinCodeConfig(node), kotlin, 'language: kotlin');
    });
  }
}
