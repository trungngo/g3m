part of g3.techlab;

/// This node captures all children's output to a file.
///
/// Important: Child nodes such as [OutputRedirect], [Console],
/// [File] might redirect the output to some where else.
///
class ReadFile implements Node {
  // The file name.
  final String name;

  /// Create a new file with the specified file [name].
  /// The file path is related to the directory specified by the nearest
  /// [Directory] ancestor.
  ///
  ReadFile(this.name);

  @override
  Node build(BuildContext context) {
    context.file = ioPath.join(context.dir, name);
    final path = context.file;

    final file = io.File(path);
    if (file.existsSync()) {
      return Text(file.readAsStringSync());
    } else {
      // final relativePath = ioPath.relative(path);
      // printWarn('$relativePath does not exist');
      return null;
    }
  }
}
