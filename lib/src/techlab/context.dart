part of g3.techlab;

typedef NodeBuildFunc<T extends Node> = Node Function(
    BuildContext context, T node);

abstract class BuildContext {
  Iterable<T> findAncestorNodesOfExactType<T>();

  /// Walks from bottom to top and try to find an ancestor
  /// with the specified type.
  ///
  T findAncestorNodeOfExactType<T extends Node>();

  /// Walks from the bottom to top to find an ancestor with the
  /// specified type. Throws exception if once could not be found.
  ///
  T dependOnAncestorNodeOfExactType<T extends Node>();

  /// Iterate through all ancestors, from bottom to top.
  Iterable<Node> get ancestors;

  /// The current directory output path.
  ///
  String dir;

  /// The current output file absolute path;
  ///
  String file;

  bool verbose;

  bool yesToAll;

  void abort();
}

abstract class RenderContext extends BuildContext {
  @override
  String get dir;

  @override
  String get file;

  StringSink out;
}

/// The abstract node type that all nodes in the tree must
/// extends from. During the build process, each node can inject
/// one sub node into the tree via [Node.build] method.
/// It is only one special node that can emit more than one node
/// to the tree is the [Container] node.
///
abstract class Node {
  Node build(BuildContext context);

  /// Parses the specify dynamic value to a node.
  factory Node.of(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is Node) {
      return value;
    } else if (value is Iterable) {
      // Converts the value list to a container.
      return Container(iterableOf(value));
    } else {
      // Just make a text value
      return _RawText(value.toString());
    }
  }

  static Iterable<Node> iterableOf(Iterable<dynamic> children) {
    if (children == null) return null;
    return children.map((e) => Node.of(e));
  }
}

/// This node has no child. The [NoChildNode.build] method does return
/// null.
///
class NoChildNode implements Node {
  @override
  Node build(BuildContext context) {
    return null;
  }
}

/// This node is a convenient node that it always return the exact
/// one child.
///
class SingleChildNode implements Node {
  final Node _child;

  SingleChildNode(this._child);

  @override
  Node build(BuildContext context) {
    return _child;
  }
}

/// A node that accepts a builder function to build its child.
///
class NodeBuilder implements Node {
  final Node Function(BuildContext context) _builder;

  NodeBuilder(this._builder);

  @override
  Node build(BuildContext context) {
    return _builder(context);
  }
}

/// This is a special node that make sure it got built only once.
///
abstract class ExactlyOneNode<T extends ExactlyOneNode<T>> implements Node {
  final Node _child;

  ExactlyOneNode(this._child);

  @override
  Node build(BuildContext context) {
    if (context.findAncestorNodeOfExactType<T>() != null) {
      // Allows maximum one instance of this class.
      return _child;
    }

    return buildOne(context, _child);
  }

  Node buildOne(BuildContext context, Node child);
}

/// This is a special node that allow the [LoopNode.build] function to
/// be called as many times as possible until the [LoopNode.isDone] property
/// is set to true. See [PromptLoop] and [PromptLoopUntil] to see how this
/// node can be used.
///
abstract class LoopNode implements Node {
  /// If this is true, the [LoopNode.build] function will not be called.
  bool get isDone;
}

abstract class Renderer {
  void render(RenderContext context);
}

abstract class PostRenderer {
  void postRender(RenderContext context);
}

abstract class _NamedNode {
  dynamic get name;
}
