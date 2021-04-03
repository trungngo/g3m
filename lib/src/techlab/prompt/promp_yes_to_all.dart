part of g3.techlab;

class PromptYesToAll implements Node {
  final Node _child;

  PromptYesToAll(this._child);

  @override
  Node build(BuildContext context) {
    context.yesToAll = true;
    return _child;
  }
}
