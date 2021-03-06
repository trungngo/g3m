part of g3.stimpack.firebase.generated;



class StimFirebaseFirestoreCollection extends StimModelSymbol<StimFirebaseFirestoreCollection> {
  StimFirebaseFirestore firestore;

  StimFirebaseFirestoreCollection parent;

  StimModelType model;

  StimModelField idField;

  StimRestCrudApi crudApi;

  bool onCreatedEvent;

  bool onUpdatedEvent;

  bool onDeletedEvent;

  Set<StimFirebaseFirestoreCollection> collections;

  StimFirebaseSecurityRule rule;

  StimRbacResource resource;

  StimFirebaseFirestoreCollection();


  /// Creates a new "firestoreCollection" of [StimFirebaseFirestoreCollection] type.
  StimFirebaseFirestoreCollection copyWith({@required
  dynamic name, @required
  StimFirebaseFirestore firestore, StimFirebaseFirestoreCollection parent, @required
  StimModelType model, @required
  StimModelField idField, StimRestCrudApi crudApi, bool onCreatedEvent, bool onUpdatedEvent, bool onDeletedEvent, Set<StimFirebaseFirestoreCollection> collections, StimFirebaseSecurityRule rule, @required
  StimRbacResource resource, Set<StimModelTag> tags}) {
    return StimFirebaseFirestoreCollection()
        ..name = StimName.of(name ?? this.name)
        ..firestore = firestore ?? this.firestore
        ..parent = parent ?? this.parent
        ..model = model ?? this.model
        ..idField = idField ?? this.idField
        ..crudApi = crudApi ?? this.crudApi
        ..onCreatedEvent = onCreatedEvent ?? this.onCreatedEvent
        ..onUpdatedEvent = onUpdatedEvent ?? this.onUpdatedEvent
        ..onDeletedEvent = onDeletedEvent ?? this.onDeletedEvent
        ..collections = collections ?? this.collections
        ..rule = rule ?? this.rule
        ..resource = resource ?? this.resource
        ..tags = tags ?? this.tags;
  }
}


class StimFirebaseFirestoreCollectionScope {
  /// Creates a new "firestoreCollection" of [StimFirebaseFirestoreCollection] type.
  StimFirebaseFirestoreCollection of({@required
  dynamic name, @required
  StimFirebaseFirestore firestore, StimFirebaseFirestoreCollection parent, @required
  StimModelType model, @required
  StimModelField idField, StimRestCrudApi crudApi, bool onCreatedEvent, bool onUpdatedEvent, bool onDeletedEvent, Set<StimFirebaseFirestoreCollection> collections, StimFirebaseSecurityRule rule, @required
  StimRbacResource resource, Set<StimModelTag> tags}) {
    return StimFirebaseFirestoreCollection()
        ..name = StimName.of(name)
        ..firestore = firestore
        ..parent = parent
        ..model = model
        ..idField = idField
        ..crudApi = crudApi
        ..onCreatedEvent = onCreatedEvent
        ..onUpdatedEvent = onUpdatedEvent
        ..onDeletedEvent = onDeletedEvent
        ..collections = collections ?? {}
        ..rule = rule
        ..resource = resource
        ..tags = tags ?? {};
  }
}
