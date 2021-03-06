part of g3.stimpack.io.generated;


/// The only instance of the [StimIo] pack.
StimIo _io;



class StimIo extends StimPack {
  StimModelPackage _metaPackage;

  /// Scope class for constructing all "file" symbols, 
  /// typed of [StimIoFile]."
  final StimIoFileScope file;

  /// Scope class for constructing all "fileType" symbols, 
  /// typed of [StimIoFileType]."
  final StimIoFileTypeScope fileType;

  /// Scope class for constructing all "dir" symbols, 
  /// typed of [StimIoDir]."
  final StimIoDirScope dir;

  final OnStimModelTypeForIo onStimModelType;

  StimIo(StimModel model):
      file = StimIoFileScope(),
      fileType = StimIoFileTypeScope(),
      dir = StimIoDirScope(),
      onStimModelType = OnStimModelTypeForIo(),
      super('io');


  /// Provides global access to the "io" pack. Only one instance of the pack 
  /// is created. During the creation, other packs that this pack depends on might 
  /// be created as well.
  static StimIo stimIoInstance() {
    if (_io == null) {
      _io = StimIo(stimpack.model);
      _io._init();
    }
    return _io;
  }

  void _init() {
    /// Builds the meta definition that defines the structure of this pack.
    _buildMeta();
  }

  void _buildMeta() {
    final m = stimpack.model, f = m.field, t = m.type;
    final mp = _metaPackage = m.package.of(name: 'io');
    final mt = onStimModelType;
    /// Builds type "file"
    mt.file = t.symbolOf(name: 'file', package: mp);

    /// Builds type "fileType"
    mt.fileType = t.symbolOf(name: 'fileType', package: mp);

    /// Builds type "dir"
    mt.dir = t.symbolOf(name: 'dir', package: mp);

    /// Builds fields for type "file"
    mt.file.fields = {
      /// field "file"
      f.of(name: 'dir', type: mt.dir),

      /// field "file"
      f.of(name: 'type', type: mt.fileType)
    };

    /// Builds fields for type "fileType"
    mt.fileType.fields = {
      /// field "fileType"
      f.of(name: 'path', type: t.fromDart(String))
    };

    /// Builds fields for type "dir"
    mt.dir.fields = {
      /// field "dir"
      f.of(name: 'path', type: t.fromDart(String)),

      /// field "dir"
      f.of(name: 'parent', type: mt.dir),

      /// field "dir"
      f.of(name: 'files', type: t.setOf(item: mt.file)),

      /// field "dir"
      f.of(name: 'dirs', type: t.setOf(item: mt.dir))
    };
  }
}
