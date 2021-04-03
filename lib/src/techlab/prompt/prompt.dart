part of g3.techlab;

abstract class PromptNode<T> implements Node {
  final String name;
  final String abbreviation;
  final T init;
  final Node child;

  PromptNode(
    this.name, {
    this.abbreviation,
    this.init,
    @required this.child,
  }) : assert(name != null);

  @override
  Node build(BuildContext context) {
    final value = _prompt(context);
    return PromptResult({name: value}, child);
  }

  T _prompt(BuildContext context);
}

