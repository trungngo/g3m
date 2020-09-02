part of g3.stimpack2.meta.techlab;

class StimGenMetaType implements Node {
  final StimModelPackage pack;
  final StimModelType type;

  Set<StimModelField> _metaFields;
  Set<StimModelTag> _metaTags;

  StimName _symbolClassName, _symbolRefClassName, _scopeClassName;

  StimpackCodeConfig _config;

  StimGenMetaType(this.pack, this.type);

  @override
  Node build(BuildContext context) {
    _initCommonFields(context);

    final fileName = _config.typeFileNameOf(pack, type);

    return DartCodeFile.of(
      fileName,
      package: _config.codePackageLibraryOf(pack, isPart: true),
      classes: [
        _symbolClassDef(),
        _symbolRefClassDef(),
        _symbolScopeClassDef(),
      ],
    );
  }

  void _initCommonFields(BuildContext context) {
    final t = stimpack.model.type.model, f = stimpack.model.field;

    _metaFields = type.fields + f.of(name: 'tags', type: t.tagSet);
    _metaTags = type.tags ?? {};

    _config = context.dependOnAncestorNodeOfExactType<StimpackCodeConfig>();

    _symbolClassName = _config.symbolClassNameOf(pack, type);
    _symbolRefClassName = _config.symbolRefClassNameOf(pack, type);
    _scopeClassName = _config.scopeClassNameOf(pack, type);
  }

  CodeClass _symbolClassDef() {
    final baseSymbolClass = CodeType.of(name: 'stim symbol', generic: [
      _symbolClassName,
    ]);

    final fields = <CodeField>{};
    for (final field in _metaFields) {
      fields.add(
        CodeField.of(
          name: field.name,
          type: field.type.name,
        ),
      );
    }

    final refField =
        CodeField.of(name: 'ref', type: _symbolRefClassName, isPrivate: true);
    fields.add(refField);

    final refProperty = _lazyInitCodeProperty(refField);

    return CodeClass.of(
      name: _symbolClassName,
      extend: baseSymbolClass,
      fields: fields.toList(),
      properties: [refProperty],
      constructors: CodeConstructor.of(),
    );
  }

  CodeClass _symbolRefClassDef() {
    final baseSymbolClass = CodeType.of(name: 'stim symbol ref', generic: [
      _symbolClassName,
    ]);

    return CodeClass.of(
      name: _symbolRefClassName,
      extend: baseSymbolClass,
      implements: _symbolClassName,
    );
  }

  CodeClass _symbolScopeClassDef() {
    final fields = <CodeField>[];

    if (type.tags != null) {
      for (final value in _metaTags) {
        // TODO: Support 1 type, multiple names
        final field = CodeField.of(
          name: value.name,
          type: _symbolClassName,
        );
        fields.add(field);
      }
    }

    final nameRef = CodeRef.of('name');
    final assignList = [
      CodeAssignExpr.of(
          nameRef,
          CodeConstructorCall.of(
              className: 'stim name', name: 'of', args: nameRef)),
      ..._metaFields.map((e) => CodeAssignExpr.of(e.name, e.name)),
    ];

    final ofFunction = _scopeClassOfFunction(
        body: CodeReturn.of(_cascadeMultiCodeLine(
      CodeConstructorCall.of(className: _symbolClassName),
      assignList,
    )));

    return CodeClass.of(
      name: _scopeClassName,
      fields: fields,
      functions: [ofFunction],
    );
  }

  CodeFunction _scopeClassOfFunction({Node body}) {
    final ofFunctionArgs = <CodeArg>[
      CodeArg.of(name: 'name', type: 'dynamic'),
    ];
    for (final i in _metaFields) {
      final required = i.isRequired ? CodeAnnotation.of('required') : null;

      ofFunctionArgs.add(
        CodeArg.of(
            name: i.name.camel(), type: i.type.name, annotations: required),
      );
    }

    return CodeFunction.of(
      name: 'of',
      returns: _symbolClassName,
      namedArgs: ofFunctionArgs,
      isOverride: body != null,
      body: body,
    );
  }
}