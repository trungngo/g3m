import 'package:g3m/stimpack_core.dart';
import 'package:g3m/stimpack_meta.dart';
import 'package:g3m/stimpack_meta_techlab.dart';
import 'package:g3m/stimpack_model.dart';

void main() {
  genRbacPack();
}

void genRbacPack() {
  final m = stimpack.model;
  final t = m.type, f = m.field;
  final meta = m.package.of(name: 'rbac');

  final tAction = t.symbolOf(name: 'action', package: meta);
  final tResource = t.symbolOf(name: 'resource', package: meta);
  final tResourceKind = t.symbolOf(name: 'resource kind', package: meta);

  final tGroup = t.symbolOf(name: 'group', package: meta);
  final tRole = t.symbolOf(name: 'role', package: meta);
  final tPolicy = t.symbolOf(name: 'policy', package: meta);
  final tPolicyKind = t.symbolOf(name: 'policy kind', package: meta);
  final tCondition = t.symbolOf(name: 'condition', package: meta);

  tGroup.fields = {
    // group can have multiple sub groups
    f.setOf(name: 'groups', type: tGroup),

    // a group can be assigned with multiple roles
    f.setOf(name: 'roles', type: tRole),
  };

  tPolicy.fields = {
    // A policy has a kind, could be accept or deny
    f.of(name: 'kind', type: tPolicyKind)..required(),

    // A policy can be applied to a set of resources
    f.setOf(name: 'resources', type: tResource)..required(),

    // A policy is applied to a set of actions that can
    // be performed on the resources
    f.setOf(name: 'actions', type: tAction)..required(),

    // The set of conditions applied to this policy.
    // If any of the condition is satisfied, then the
    // policy is applied.
    f.setOf(name: 'conditions', type: tCondition)..required(),
  };

  tResource.fields = {
    // If this field is specified then the resource is applied
    // to just a single instance. Other, it will applied to
    // all instances of a kind.
    f.of(name: 'kind', type: tResourceKind),

    // A resource might have a parent resource
    f.of(name: 'parent', type: tResource),
  };

  tRole.fields = {
    // a role can have all permissions that all sub roles have.
    f.setOf(name: 'roles', type: tRole),
  };

  tAction.fields = {
    f.setOf(name: 'actions', type: tAction),
  };

  tCondition.fields = {
    f.of(name: 'if has role', type: tRole),

    // If this field is specified than the user has any of
    // the specified roles
    f.setOf(name: 'if has any roles', type: tRole),

    // If this field is specified than the user has all of
    // the specified roles
    f.setOf(name: 'if has all roles', type: tRole),

    // If this field is specified than any of the conditions must match
    f.setOf(name: 'if any of', type: tCondition),

    // If this field is specified than all the sub conditions must match
    f.setOf(name: 'if all of', type: tCondition),
  };

  stimpackGen(meta, 'lib/src/stimpack', values: {
    t.model.field: _fields,
    tPolicyKind: {'allow', 'deny'},
    tResource: _resources,
    tResourceKind: _resourceKinds,
    tRole: _roles,
    tAction: _actions,
    tCondition: _conditions,
  });
}

final _fields = {
  'group',
  'group set',
  'policy',
  'policy set',
  'resource',
  'resource set',
  'role',
  'role set',
  'action',
  'action set',
  'condition',
  'condition set',
};

final _resources = {
  /// This match any resource in the system
  'root',
};

final _resourceKinds = {
  'root',
};

final _roles = {
  'super admin',
  'admin',
  'user',
  'guest',
};

final _actions = {
  'create one',
  'find one',
  'update one',
  'delete one',
  'delete',
  'find',
  'read',
  'write',
  'read write',
  'read write delete',
};

final _conditions = {
  'is user',
  'is guest',
  'is owner',
  'is shared',
  'is in role',
  'is in super admin role',
  'is in admin role',
  'is in user role',
};
