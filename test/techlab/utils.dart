import 'package:g3m/techlab_core.dart';
import 'package:test/test.dart';

void runAndExpect(Node node, [String expected, String reason]) {
  final buf = StringBuffer();
  Program.execute(OutputRedirect(buf, node));
  final actual = buf.toString();

  if (expected != null) expect(actual, expected, reason: reason);
}
