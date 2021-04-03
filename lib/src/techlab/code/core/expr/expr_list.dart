part of g3.techlab;

enum CodeOpStyle {
  op,
  opExpr,
  exprOpExpr,
  opExpr2,
  exprOpExpr2,
}

class CodeOp {
  final String name;
  final CodeOpStyle style;

  const CodeOp.op(this.name) : style = CodeOpStyle.op;

  const CodeOp.opExpr(this.name) : style = CodeOpStyle.opExpr;

  const CodeOp.exprOpExpr(this.name) : style = CodeOpStyle.exprOpExpr;

  const CodeOp.opExpr2(this.name) : style = CodeOpStyle.opExpr2;

  const CodeOp.exprOpExpr2(this.name) : style = CodeOpStyle.exprOpExpr2;
}

class CodeOps {
  static const CodeOp equalOp = CodeOp.exprOpExpr('==');
  static const CodeOp notEqualOp = CodeOp.exprOpExpr('!=');
  static const CodeOp greaterThanOp = CodeOp.exprOpExpr('>');
  static const CodeOp greaterThanOrEqualOp = CodeOp.exprOpExpr('>=');
  static const CodeOp lessThanOp = CodeOp.exprOpExpr('<');
  static const CodeOp lessThanOrEqualOp = CodeOp.exprOpExpr('<=');

  // Type test operators
  static const CodeOp asOp = CodeOp.exprOpExpr('as');
  static const CodeOp isOp = CodeOp.exprOpExpr('is');
  static const CodeOp isNotOp = CodeOp.exprOpExpr('is!');

  // Arithmetic operator
  static const CodeOp plusOp = CodeOp.exprOpExpr('+');
  static const CodeOp minusOp = CodeOp.exprOpExpr('-');
  static const CodeOp multiplyOp = CodeOp.exprOpExpr('*');
  static const CodeOp divideOp = CodeOp.exprOpExpr('/');
  static const CodeOp divOp = CodeOp.exprOpExpr('~/');
  static const CodeOp modOp = CodeOp.exprOpExpr('%');

  // Bitwise and shift operators
  static const CodeOp bitShiftLeftOp = CodeOp.exprOpExpr('<<');
  static const CodeOp bitShiftRightOp = CodeOp.exprOpExpr('>>');
  static const CodeOp bitAndOp = CodeOp.exprOpExpr('&');
  static const CodeOp bitOrOp = CodeOp.exprOpExpr('|');
  static const CodeOp bitXorOp = CodeOp.exprOpExpr('^');
  static const CodeOp bitNegateOp = CodeOp.opExpr('~');

  // Assignment operators
  static const CodeOp assignOp = CodeOp.exprOpExpr('=');
  static const CodeOp assignIfNullOp = CodeOp.exprOpExpr('??=');
  static const CodeOp plusAssignOp = CodeOp.exprOpExpr('+=');
  static const CodeOp minusAssignOp = CodeOp.exprOpExpr('-=');
  static const CodeOp multiplyAssignOp = CodeOp.exprOpExpr('*=');
  static const CodeOp divideAssignOp = CodeOp.exprOpExpr('/=');
  static const CodeOp modAssignOp = CodeOp.exprOpExpr('%=');
  static const CodeOp bitShiftLeftAssignOp = CodeOp.exprOpExpr('<<=');
  static const CodeOp bitShiftRightAssignOp = CodeOp.exprOpExpr('>>=');
  static const CodeOp bitAndAssignOp = CodeOp.exprOpExpr('&=');
  static const CodeOp bitOrAssignOp = CodeOp.exprOpExpr('|=');
  static const CodeOp bitXorAssignOp = CodeOp.exprOpExpr('^=');

  // Logical operators
  static const CodeOp logicalNotOp = CodeOp.opExpr('!');
  static const CodeOp logicalAndOp = CodeOp.exprOpExpr('&&');
  static const CodeOp logicalOrOp = CodeOp.exprOpExpr('||');

  // Conditional operators
  static const CodeOp conditionalOp = CodeOp.exprOpExpr2('?:');
  static const CodeOp conditionalNullOp = CodeOp.exprOpExpr('??');

  // Access or call operators
  static const CodeOp newOp = CodeOp.opExpr('new');
  static const CodeOp accessOp = CodeOp.exprOpExpr('.');
  static const CodeOp cascadeOp = CodeOp.opExpr('..');
  static const CodeOp annotationOp = CodeOp.opExpr('@');
  static const CodeOp conditionalAccessOp = CodeOp.exprOpExpr('?.');
  static const CodeOp listAccessOp = CodeOp.exprOpExpr('[]');
  static const CodeOp arrowOp = CodeOp.opExpr(' => ');
  static const CodeOp nameArgOp = CodeOp.exprOpExpr(':');

  // Misc operators
  static const CodeOp yieldOp = CodeOp.opExpr('yield ');
  static const CodeOp yieldAsyncOp = CodeOp.opExpr('yield* ');

  static const CodeOp awaitOp = CodeOp.opExpr('await ');

  static const CodeOp breakOp = CodeOp.op('break');
  static const CodeOp continueOp = CodeOp.op('continue');

  static const CodeOp returnOp = CodeOp.op('return');
  static const CodeOp returnSingleOp = CodeOp.opExpr('return ');
}

class CodeExprListConfig extends CodeConfigNode<CodeExprList> {
  CodeExprListConfig(NodeBuildFunc<CodeExprList> buildFunc, Node child)
      : super(buildFunc, child);

  static Node _default(CodeExprList expr, Node child) {
    if (child == null) {
      final op = expr.op;
      final name = op.name;
      final e1 = expr.e1;
      final e2 = expr.e2;
      final e3 = expr.e3;

      switch (op) {
        case CodeOps.nameArgOp:
          child = Container([e1, ': ', e2]);
          break;
        case CodeOps.newOp:
          child = Container([name, ' ', e1]);
          break;
        case CodeOps.listAccessOp:
          child = Container([e1, '[', e2, ']']);
          break;

        case CodeOps.accessOp:
          child = Container([e1, '.', e2]);
          break;
        case CodeOps.conditionalAccessOp:
          child = Container([e1, '?.', e2]);
          break;
        case CodeOps.conditionalOp:
          child = Container([e1, ' ? ', e2, ' : ', e3]);
          break;

        case CodeOps.divOp:
          child = Container([e1, ' / ', e2]);
          break;

        default:
          switch (op.style) {
            case CodeOpStyle.op:
              child = Container([name]);
              break;
            case CodeOpStyle.opExpr:
              child = Container([name, e1]);
              break;
            case CodeOpStyle.exprOpExpr:
              child = Container([e1, ' ', name, ' ', e2]);
              break;
            //
            case CodeOpStyle.opExpr2:
              child = Container([name, ' ', e1, ' ', e2]);
              break;

            case CodeOpStyle.exprOpExpr2:
              child = Container([e1, ' ', name, ' ', e2, ' ', e3]);
              break;
          }
      }
    }

    return CodeExpr.open(child);
  }

  factory CodeExprListConfig.forDartLike(Node child) =>
      CodeExprListConfig((context, expr) {
        Node child;
        final op = expr.op;
        final e1 = expr.e1;
        final e2 = expr.e2;

        switch (op) {
          case CodeOps.divOp:
            child = Container([e1, ' ~/ ', e2]);
            break;
        }
        return _default(expr, child);
      }, child);

  factory CodeExprListConfig.forTypescriptLike(Node child) =>
      CodeExprListConfig((context, expr) {
        Node child;
        final op = expr.op;
        final e1 = expr.e1;
        final e2 = expr.e2;

        switch (op) {
          case CodeOps.isOp:
            child = Container([e1, ' instanceof ', e2]);
            break;
          case CodeOps.isNotOp:
            child = Container([e1, ' !instanceof ', e2]);
            break;
          case CodeOps.cascadeOp:
            throw "Typescript don't support cascade expr";
            break;
        }

        return _default(expr, child);
      }, child);

  factory CodeExprListConfig.forJavaLike(Node child) =>
      CodeExprListConfig((context, expr) {
        Node child;
        final op = expr.op;
        final e1 = expr.e1;
        final e2 = expr.e2;

        switch (op) {
          case CodeOps.asOp:
            child = Container(['((', e2, ') ', e1, ')']);
            break;
          case CodeOps.isOp:
            child = Container([e1, ' instanceof ', e2]);
            break;
          case CodeOps.isNotOp:
            child = Container(['!(', e1, ' instanceof ', e2, ')']);
            break;
          case CodeOps.assignIfNullOp:
            child = Container([e1, ' = ', e1, ' == null? ', e2, ' : ', e1]);
            break;
          case CodeOps.conditionalAccessOp:
            child = Container(['(', e1, ' == null? null : ', e1, '.', e2, ')']);
            break;
          case CodeOps.cascadeOp:
            throw "Java don't support cascade expr";
            break;
        }

        return _default(expr, child);
      }, child);

  factory CodeExprListConfig.forKotlinLike(Node child) =>
      CodeExprListConfig((context, expr) {
        Node child;
        final op = expr.op;
        final e1 = expr.e1;
        final e2 = expr.e2;
        final e3 = expr.e3;

        switch (op) {
          case CodeOps.isNotOp:
            child = Container([e1, ' !is ', e2]);
            break;
          case CodeOps.bitShiftLeftOp:
            child = Container([e1, ' shl ', e2]);
            break;
          case CodeOps.bitShiftLeftAssignOp:
            child = Container([e1, ' = ', e1, ' shl ', e2]);
            break;
          case CodeOps.bitShiftRightOp:
            child = Container([e1, ' shr ', e2]);
            break;
          case CodeOps.bitShiftRightAssignOp:
            child = Container([e1, ' = ', e1, ' shr ', e2]);
            break;
          case CodeOps.bitAndOp:
            child = Container([e1, ' and ', e2]);
            break;
          case CodeOps.bitAndAssignOp:
            child = Container([e1, ' = ', e1, ' and ', e2]);
            break;
          case CodeOps.bitOrOp:
            child = Container([e1, ' or ', e2]);
            break;
          case CodeOps.bitOrAssignOp:
            child = Container([e1, ' = ', e1, ' or ', e2]);
            break;
          case CodeOps.bitXorOp:
            child = Container([e1, ' xor ', e2]);
            break;
          case CodeOps.bitXorAssignOp:
            child = Container([e1, ' = ', e1, ' xor ', e2]);
            break;
          case CodeOps.bitNegateOp:
            child = Container([e1, '.inv()']);
            break;
          case CodeOps.conditionalOp:
            child = Container(['if (', e1, ') ', e2, ' else ', e3]);
            break;
          case CodeOps.conditionalNullOp:
            child = Container(['if (', e1, ' == null) ', e2, ' else ', e1]);
            break;
          case CodeOps.assignIfNullOp:
            child =
                Container([e1, ' = if (', e1, ' == null) ', e2, ' else ', e1]);
            break;
          case CodeOps.cascadeOp:
            throw "Kotlin don't support cascade expr";
            break;
        }

        return _default(expr, child);
      }, child);
}

class CodeExprList extends CodeConfigProxyNode<CodeExprList> {
  final CodeOp op;
  final CodeExpr e1;
  final CodeExpr e2;
  final CodeExpr e3;

  CodeExprList._({
    @required this.op,
    this.e1,
    this.e2,
    this.e3,
  }) : assert(op != null, 'op is required') {
    final style = op.style;

    if (style == CodeOpStyle.op) {
      assert(e1 == null && e2 == null && e3 == null,
          '${op.name} must have zero operand.');
    } else if (style == CodeOpStyle.opExpr) {
      assert(e1 != null && e2 == null && e3 == null,
          '${op.name} must have 1 operands only.');
    } else if (style == CodeOpStyle.opExpr2 ||
        style == CodeOpStyle.exprOpExpr ||
        style == CodeOpStyle.opExpr2) {
      assert(e1 != null && e2 != null && e3 == null,
          '${op.name} must have 2 operands.');
    } else {
      assert(e1 != null && e2 != null && e3 != null,
          '${op.name} must have 3 operands.');
    }
  }

  factory CodeExprList.of({
    @required CodeOp op,
    dynamic expr1,
    dynamic expr2,
    dynamic expr3,
  }) {
    if (op == null && expr1 == null && expr2 == null && expr3 == null) {
      return null;
    }

    return CodeExprList._(
      op: op,
      e1: CodeExpr.of(expr1),
      e2: CodeExpr.of(expr2),
      e3: CodeExpr.of(expr3),
    );
  }
}

class CodeEqualExpr extends SingleChildNode {
  CodeEqualExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.equalOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeNotEqualExpr extends SingleChildNode {
  CodeNotEqualExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.notEqualOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeGreaterThanExpr extends SingleChildNode {
  CodeGreaterThanExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.greaterThanOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeGreaterThanOrEqualExpr extends SingleChildNode {
  CodeGreaterThanOrEqualExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.greaterThanOrEqualOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeLessThanExpr extends SingleChildNode {
  CodeLessThanExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.lessThanOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeLessThanOrEqualExpr extends SingleChildNode {
  CodeLessThanOrEqualExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.lessThanOrEqualOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeAsExpr extends SingleChildNode {
  CodeAsExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.asOp,
            expr1: CodeRef.of(e1),
            expr2: CodeRef.of(e2),
          ),
        ));
}

class CodeIsExpr extends SingleChildNode {
  CodeIsExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.isOp,
            expr1: CodeRef.of(e1),
            expr2: CodeRef.of(e2),
          ),
        ));
}

class CodeIsNotExpr extends SingleChildNode {
  CodeIsNotExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.isNotOp,
            expr1: CodeRef.of(e1),
            expr2: CodeRef.of(e2),
          ),
        ));
}

class CodePlusExpr extends SingleChildNode {
  CodePlusExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.plusOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeMinusExpr extends SingleChildNode {
  CodeMinusExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.minusOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeMultiplyExpr extends SingleChildNode {
  CodeMultiplyExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.multiplyOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeDivideExpr extends SingleChildNode {
  CodeDivideExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.divideOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeDivExpr extends SingleChildNode {
  CodeDivExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.divOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeModExpr extends SingleChildNode {
  CodeModExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.modOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeBitShiftLeftExpr extends SingleChildNode {
  CodeBitShiftLeftExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.bitShiftLeftOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeBitShiftRightExpr extends SingleChildNode {
  CodeBitShiftRightExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.bitShiftRightOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeBitAndExpr extends SingleChildNode {
  CodeBitAndExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.bitAndOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeBitOrExpr extends SingleChildNode {
  CodeBitOrExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.bitOrOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeBitXorExpr extends SingleChildNode {
  CodeBitXorExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.bitXorOp,
            expr1: e1,
            expr2: e2,
          ),
        ));
}

class CodeBitNegateExpr extends SingleChildNode {
  CodeBitNegateExpr.of(dynamic e1)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.bitNegateOp,
            expr1: e1,
          ),
        ));
}

class CodeAssignExpr extends SingleChildNode {
  CodeAssignExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.assignOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeAssignIfNullExpr extends SingleChildNode {
  CodeAssignIfNullExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.assignIfNullOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodePlusAssignExpr extends SingleChildNode {
  CodePlusAssignExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.plusAssignOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeMinusAssignExpr extends SingleChildNode {
  CodeMinusAssignExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.minusAssignOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeMultiplyAssignExpr extends SingleChildNode {
  CodeMultiplyAssignExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.multiplyAssignOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeDivideAssignExpr extends SingleChildNode {
  CodeDivideAssignExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.divideAssignOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeModAssignExpr extends SingleChildNode {
  CodeModAssignExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.modAssignOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeBitShiftLeftAssignExpr extends SingleChildNode {
  CodeBitShiftLeftAssignExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.bitShiftLeftAssignOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeBitShiftRightAssignExpr extends SingleChildNode {
  CodeBitShiftRightAssignExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.bitShiftRightAssignOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeBitAndAssignExpr extends SingleChildNode {
  CodeBitAndAssignExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.bitAndAssignOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeBitOrAssignExpr extends SingleChildNode {
  CodeBitOrAssignExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.bitOrAssignOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeBitXorAssignExpr extends SingleChildNode {
  CodeBitXorAssignExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.bitXorAssignOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeLogicalNotExpr extends SingleChildNode {
  CodeLogicalNotExpr.of(dynamic e1)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.logicalNotOp,
            expr1: CodeRef.of(e1),
          ),
        ));
}

class CodeLogicalAndExpr extends SingleChildNode {
  CodeLogicalAndExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.logicalAndOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeLogicalOrExpr extends SingleChildNode {
  CodeLogicalOrExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.logicalOrOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeConditionalExpr extends SingleChildNode {
  CodeConditionalExpr.of(dynamic e1, dynamic e2, dynamic e3)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.conditionalOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
            expr3: e3,
          ),
        ));
}

class CodeConditionalNullExpr extends SingleChildNode {
  CodeConditionalNullExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.conditionalNullOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeNewExpr extends SingleChildNode {
  CodeNewExpr.of(dynamic e1)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.newOp,
            expr1: CodeRef.of(e1),
          ),
        ));
}

class CodeAccessExpr extends SingleChildNode {
  CodeAccessExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.accessOp,
            expr1: CodeRef.of(e1),
            expr2: CodeRef.of(e2),
          ),
        ));
}

class CodeCascadeExpr extends SingleChildNode {
  CodeCascadeExpr.of(dynamic e1)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.cascadeOp,
            expr1: CodeRef.of(e1),
          ),
        ));
}

class CodeAnnotation extends SingleChildNode {
  CodeAnnotation.of(dynamic e1)
      : super(CodeExpr.closed(
          CodeExprList.of(
            op: CodeOps.annotationOp,
            expr1: CodeRef.of(e1),
          ),
        ));

  factory CodeAnnotation.required() => CodeAnnotation.of('required');

  factory CodeAnnotation.override() => CodeAnnotation.of('override');

  factory CodeAnnotation.functionCall({
    @required dynamic name,
    dynamic instance,
    dynamic generic,
    dynamic args,
  }) {
    return CodeAnnotation.of(
      CodeFunctionCall.of(
        name: name,
        instance: instance,
        generic: generic,
        args: args,
      ),
    );
  }

  factory CodeAnnotation.constructorCall({
    dynamic instance,
    @required dynamic className,
    dynamic name,
    dynamic generic,
    dynamic args,
  }) {
    return CodeAnnotation.of(
      CodeConstructorCall.of(
        className: className,
        instance: instance,
        generic: generic,
        name: name,
        args: args,
      ),
    );
  }
}

class CodeConditionalAccessExpr extends SingleChildNode {
  CodeConditionalAccessExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.conditionalAccessOp,
            expr1: CodeRef.of(e1),
            expr2: CodeRef.of(e2),
          ),
        ));
}

class CodeArrowExpr extends SingleChildNode {
  CodeArrowExpr.of(dynamic e1)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.arrowOp,
            expr1: e1,
          ),
        ));
}

class CodeNameArgExpr extends SingleChildNode {
  CodeNameArgExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.nameArgOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeListAccessExpr extends SingleChildNode {
  CodeListAccessExpr.of(dynamic e1, dynamic e2)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.listAccessOp,
            expr1: CodeRef.of(e1),
            expr2: e2,
          ),
        ));
}

class CodeYieldExpr extends SingleChildNode {
  CodeYieldExpr.of(dynamic e1)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.yieldOp,
            expr1: CodeRef.of(e1),
          ),
        ));
}

class CodeYieldAsyncExpr extends SingleChildNode {
  CodeYieldAsyncExpr.of(dynamic e1)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.yieldAsyncOp,
            expr1: CodeRef.of(e1),
          ),
        ));
}

class CodeAwaitExpr extends SingleChildNode {
  CodeAwaitExpr.of(dynamic e1)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.awaitOp,
            expr1: CodeRef.of(e1),
          ),
        ));
}

class CodeBreakExpr extends SingleChildNode {
  CodeBreakExpr()
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.breakOp,
          ),
        ));
}

class CodeContinueExpr extends SingleChildNode {
  CodeContinueExpr()
      : super(CodeExpr.open(
          CodeExprList.of(
            op: CodeOps.continueOp,
          ),
        ));
}

class CodeReturnExpr extends SingleChildNode {
  CodeReturnExpr.of(dynamic e1)
      : super(CodeExpr.open(
          CodeExprList.of(
            op: e1 == null ? CodeOps.returnOp : CodeOps.returnSingleOp,
            expr1: e1,
          ),
        ));

  factory CodeReturnExpr.ofNull() => CodeReturnExpr.of(CodeNullLiteral());

  factory CodeReturnExpr.ofTrue() =>
      CodeReturnExpr.of(CodeBoolLiteral.of(true));

  factory CodeReturnExpr.ofFalse() =>
      CodeReturnExpr.of(CodeBoolLiteral.of(false));

  factory CodeReturnExpr() => CodeReturnExpr.of(null);
}
