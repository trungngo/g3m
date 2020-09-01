part of g3.stimpack2.rbac;

class StimRbacGroupScope {
  StimRbacGroup of({
    @required dynamic name,
    Set<StimModelTag> tags,
  }) =>
      StimRbacGroup()
        ..name = StimName.of(name)
        ..tags = tags;
}

class StimRbacGroup extends StimModelSymbol<StimRbacGroup> {
  Set<StimRbacGroup> groups;
  Set<StimRbacRole> roles;

  StimRbacGroup();
}