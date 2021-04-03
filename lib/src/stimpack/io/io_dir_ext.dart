part of g3.stimpack.io.init;

extension OnDirScopeIoExtension on StimIoDirScope {
  StimIoDir absoluteDirOf({
    @required String path,
    bool exists,
    Set<StimIoFile> files,
    Set<StimIoDir> dirs,
    Set<StimModelTag> tags,
  }) {
    assert(path != null, 'path is required');
    if (exists == true) {
      assert(io.Directory(path).existsSync(),
          'Directory ${path} does not exists.');
    }

    final name = io_path.basename(path);
    path = io_path.dirname(path);

    final dir = of(
      name: name,
      path: path,
      parent: null,
      files: files,
      dirs: dirs,
      tags: tags,
    );

    files?.forEach((f) {
      f.dir = dir;
      dir.files += f;
    });

    dirs?.forEach((d) {
      d.parent = dir;
      dir.dirs += d;
    });

    return dir;
  }
}

extension OnDirScopeExtension on StimIoDir {
  StimIoDir childDir({
    @required String path,
    bool exists,
    Set<StimIoFile> files,
    Set<StimIoDir> dirs,
    Set<StimModelTag> tags,
  }) {
    final childDir = stimpack.io.dir.of(
      name: path,
      path: path,
      files: files,
      dirs: dirs,
      tags: tags,
    );

    childDir.parent = this;

    if (exists == true) {
      assert(childDir.exists,
          'Directory ${childDir.absolutePath} does not exists.');
    }

    this.dirs += childDir;

    return childDir;
  }

  /// Gets out the ancestors, nearest first.
  Iterable<StimIoDir> get ancestors sync* {
    var d = parent;
    while (d != null) {
      yield d;
      d = d.parent;
    }
  }

  /// Gets the absolute path for the current directory.
  String get absolutePath {
    var d = this;
    final parts = <String>[];
    while (d != null) {
      parts.add(d.name.toString());
      if (d.path != null) parts.add(d.path);
      d = d.parent;
    }

    final fullPath = io_path.joinAll(parts.reversed);
    return io_path.normalize(fullPath);
  }

  /// Determines if the directory must exists.
  bool get exists {
    final dir = io.Directory(absolutePath);
    return dir.existsSync();
  }

  /// Builds an absolute path string of a child path.
  String absolutePathOf(String child) {
    assert(child != null);
    return io_path.join(absolutePath, child);
  }
}
