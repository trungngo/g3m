part of g3.techlab;

class CodePropertyConfig extends CodeConfigNode<CodeProperty> {
  CodePropertyConfig(NodeBuildFunc<CodeProperty> buildFunc, Node child)
      : super(buildFunc, child);

  factory CodePropertyConfig.forDartLike(Node child) =>
      CodePropertyConfig._internal(child, overrideAsAnnotation: true);

  factory CodePropertyConfig.forTypescriptLike(Node child) =>
      CodePropertyConfig._internal(child, overrideAsAnnotation: true);

  factory CodePropertyConfig.forJavaLike(Node child) =>
      CodePropertyConfig._internal(child);

  factory CodePropertyConfig.forKotlinLike(Node child) =>
      CodePropertyConfig._internal(child, generateField: true);

  factory CodePropertyConfig._internal(
    Node child, {
    bool overrideAsAnnotation,
    bool generateField,
  }) =>
      CodePropertyConfig((context, property) {
        // The data field representing the property.
        // Property getter
        Node getter = property.getter;

        // Property setter
        Node setter = property.setter;

        Node def = Container([
          getter,
          // Adds a new line to separate getter and setter.
          getter != null && setter != null ? '\n' : null,
          setter,
        ]);

        if (generateField == true) {
          def = Container([
            CodeField.of(
              name: property.name,
              isFinal: setter == null,
              type: property.type,
            ),
            NewLine(),
            Indent(def),
          ]);
        }

        return def;
      }, child);
}

class CodeProperty extends CodeConfigProxyNode<CodeProperty>
    implements _NamedNode {
  /// The property name.
  @override
  final CodePropertyName name;

  /// The list of annotations for the property.
  final CodeAnnotationList annotations;

  /// The property modifier
  final CodeModifier modifier;

  /// The data type of the property
  final CodeType type;

  /// Get getter function for the property
  final CodePropertyGetter getter;

  /// Get setter function for the property
  final CodePropertySetter setter;

  /// The comment for the property
  final CodeComment comment;

  CodeProperty({
    @required this.name,
    this.annotations,
    this.modifier,
    @required this.type,
    this.getter,
    this.setter,
    this.comment,
  }) {
    assert(name != null, 'property name is required');
    assert(type != null, 'property type is required');
    assert(getter != null || setter != null,
        'either setter or getter must be specified for property.');
  }

  factory CodeProperty.of({
    @required dynamic name,
    dynamic annotations,
    bool isOverride,
    bool isPrivate,
    bool isPublic,
    bool isProtected,
    bool isInternal,
    bool isAbstract,
    dynamic type,
    dynamic getter,
    dynamic setter,
    dynamic comment,
  }) {
    return CodeProperty(
      name: CodePropertyName.of(name),
      annotations: CodeAnnotationList.of(annotations),
      modifier: CodeModifier(
        isOverride: isOverride,
        isPrivate: isPrivate,
        isPublic: isPublic,
        isProtected: isProtected,
        isInternal: isInternal,
        isAbstract: isAbstract,
      ),
      type: CodeType._parse(type, error: () {
        throw '$type is not a valid type.';
      }),
      getter: CodePropertyGetter._parse(getter, error: () {
        throw 'Invalid $getter found.';
      }),
      setter: CodePropertySetter._parse(setter, error: () {
        throw 'Invalid $setter found.';
      }),
      comment: CodeComment.of(comment),
    );
  }

  factory CodeProperty.ofField({
    @required CodeField field,
    dynamic annotations,
    dynamic type,
    bool isOverride,
    bool isPrivate,
    bool isPublic,
    bool isProtected,
    bool isInternal,
    dynamic comment,
    bool setter,
    bool getter,
  }) {
    assert(setter == true || getter == true,
        'either setter or getter must be true');

    return CodeProperty.of(
      name: field.name,
      type: type ?? field.type,
      annotations: annotations,
      isOverride: isOverride,
      isPrivate: isPrivate,
      isPublic: isPublic,
      isProtected: isProtected,
      isInternal: isInternal,
      comment: comment,
      getter: getter == true
          ? CodePropertyGetter.of(body: CodeReturn.of(field.name))
          : null,
      setter: setter == true
          ? CodePropertySetter.of(
              body: CodeAssignExpr.of(field.name, CodeRef.of('value')))
          : null,
    );
  }
}
