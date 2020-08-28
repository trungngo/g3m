part of g3.stimpack.model.generated;

class StimModelTypeXRulesSetOp extends StimSymbolSetOpImpl<StimModelType, StimModelTypeSet, StimModelRule, StimModelRuleSet> {
  StimModelTypeXRulesSetOp(StimSymbolSet<StimSymbol, StimSymbolSet> symbols,
      StimScope<StimModelRule, StimModelRuleSet> scope)
      : super(symbols, scope);

  @override
  void onAdd(StimModelType child, StimModelRuleSet values) {
    child.rules += values;
  }

  @override
  void onSet(StimModelType child, StimModelRuleSet values) {
    child.rules = values;
  }
}
    