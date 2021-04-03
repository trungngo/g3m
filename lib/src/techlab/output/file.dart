part of g3.techlab;

/// This node captures all children's output to a file.
///
/// Important: Child nodes such as [OutputRedirect], [Console],
/// [File] might redirect the output to some where else.
///
class File implements Node, Renderer, PostRenderer {
  // The file name.
  final String name;

  // The file content.
  final Node content;

  /// True indicates that the file need to be overwrite all the time.
  /// False indicates that the file never get overwrite.
  /// null indicates that needs human confirm.
  final bool overwriteIfExists;

  // The internal string buffer that captures all children's output.
  StringBuffer _buf;

  bool _ignored;

  /// Create a new file with the specified file [name].
  /// The file path is related to the directory specified by the nearest
  /// [Directory] ancestor.
  ///
  File._(this.name, this.content, this.overwriteIfExists)
      : assert(name?.isNotEmpty == true, 'name is required');

  factory File.of(String name, Node content, {bool overwriteIfExists}) {
    return File._(name, content, overwriteIfExists);
  }

  factory File.confirmOverwrite(String name, Node content) {
    return File._(name, content, null);
  }

  factory File.alwaysOverwrite(String name, Node content) {
    return File._(name, content, true);
  }

  factory File.neverOverwrite(String name, Node content) {
    return File._(name, content, false);
  }

  @override
  Node build(BuildContext context) {
    context.file = ioPath.join(context.dir, name);
    _ignored = GlobIgnore.isIgnored(context, context.file);
    if (_ignored) return null;

    return content;
  }

  @override
  void render(RenderContext context) {
    if (_ignored == true) return;

    // Redirect all children's output to the new string buffer.
    _buf = StringBuffer();
    context.out = _buf;
  }

  @override
  void postRender(RenderContext context) async {
    final path = context.file;
    final relativePath = ioPath.relative(path);

    if (_ignored == true) {
      printWarn('$relativePath file is ignored');
      return;
    }

    final file = io.File(path);
    final content = _buf.toString();
    _buf = null;

    if (!file.existsSync()) {
      printInfo('$relativePath has been generated.');
    } else {
      // Reads out the existing content to compare with the latest
      // content. If the content has been modified, prompt the user
      // to see if they want to overwrite it.
      final existingContent = file.readAsStringSync();

      final diffs = diff.diff(existingContent, content);

      final notModified = diffs.isEmpty ||
          diffs.length == 1 && diffs[0].operation == diff.DIFF_EQUAL;

      if (notModified) {
        // The content has not been modified, just skip it.
        if (context.verbose == true) {
          print('$relativePath has not been modified.');
        }
        return;
      }

      if (overwriteIfExists == false) {
        if (context.verbose == true) {
          printWarn(
              '$relativePath has been modified, but skipped because of hard settings.');
        }
        return;
      } else if (overwriteIfExists == true || context.yesToAll == true) {
        printInfo('$relativePath has been overwritten.');
      } else {
        diff.cleanupSemantic(diffs);

        final patches = diff.patchMake(existingContent, b: diffs);
        _patchToText(patches);

        // The content has been modified. Need to prompt.
        final no = 'No, skip it.';
        final yes = 'Yes. Overwrite';
        final yesToAll = 'Yes and stop asking. Overwrite everything';
        final abort = 'Abort';

        final options = {
          'n': no,
          'y': yes,
          '*': yesToAll,
          'a': abort,
        };

        final message =
            '$relativePath file has been modified. Do you want to overwrite?';

        // Prompt user to see what they want to do with the file.
        final choice = prompts.choose(
          message,
          options.values,
          defaultsTo: no,
          names: options.keys,
        );

        if (choice == abort) {
          // Abort rendering.
          context.abort();
          return;
        } else if (choice == no) {
          // Skips the file.
          printWarn('$relativePath has been skipped.');
          return;
        } else if (choice == yesToAll) {
          // Overwrite the file.
          printWarn('$relativePath and all other changes will be overwrite.');
          context.yesToAll = true;
        } else {
          printInfo('$relativePath has been overwritten.');
        }
      }
    }

    file.writeAsStringSync(content, flush: true);
  }

  void _patchToText(List<diff.Patch> patches) {
    for (final aPatch in patches) {
      _printPatch(aPatch);
    }
  }

  /// TODO: Pretty print
  void _printPatch(diff.Patch patch) {
    String coords1, coords2;

    if (patch.length1 == 0) {
      coords1 = '${patch.start1},0';
    } else if (patch.length1 == 1) {
      coords1 = (patch.start1 + 1).toString();
    } else {
      coords1 = '${patch.start1 + 1},${patch.length1}';
    }
    if (patch.length2 == 0) {
      coords2 = '${patch.start2},0';
    } else if (patch.length2 == 1) {
      coords2 = (patch.start2 + 1).toString();
    } else {
      coords2 = '${patch.start2 + 1},${patch.length2}';
    }

    for (final aDiff in patch.diffs) {
      final text = aDiff.text;
      switch (aDiff.operation) {
        case diff.DIFF_INSERT:
          printInfo('@@ -$coords1 +$coords2 @@\n');
          printSuccess('+${text}\n');
          break;
        case diff.DIFF_DELETE:
          printInfo('@@ -$coords1 +$coords2 @@\n');
          printError('-${text}\n');
          break;
      }
    }
  }
}
