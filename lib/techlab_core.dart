library g3.techlab;

import 'dart:io' as io;
import 'package:glob/glob.dart' as glob;
import 'package:diff_match_patch/diff_match_patch.dart' as diff;


import 'package:g3m/util.dart';
import 'package:meta/meta.dart';
import 'package:mustache/mustache.dart';
import 'package:path/path.dart' as ioPath;
import 'package:prompts/prompts.dart' as prompts;

part 'src/techlab/code/core/annotation/annotation-list.dart';

part 'src/techlab/code/core/arg/arg.dart';

part 'src/techlab/code/core/arg/arg_list.dart';

part 'src/techlab/code/core/arg/arg_name.dart';

part 'src/techlab/code/core/block.dart';

part 'src/techlab/code/core/class/class-list.dart';

part 'src/techlab/code/core/class/class-name.dart';

part 'src/techlab/code/core/class/class.dart';

part 'src/techlab/code/core/comment.dart';

part 'src/techlab/code/core/config.dart';

part 'src/techlab/code/core/constructor/constructor-list.dart';

part 'src/techlab/code/core/constructor/constructor-name.dart';

part 'src/techlab/code/core/constructor/constructor.dart';

part 'src/techlab/code/core/enum/enum-list.dart';

part 'src/techlab/code/core/enum/enum-name.dart';

part 'src/techlab/code/core/enum/enum-value-list.dart';

part 'src/techlab/code/core/enum/enum-value-name.dart';

part 'src/techlab/code/core/enum/enum-value.dart';

part 'src/techlab/code/core/enum/enum.dart';

part 'src/techlab/code/core/expr/cascade.dart';

part 'src/techlab/code/core/expr/constructor-call.dart';

part 'src/techlab/code/core/expr/expr.dart';

part 'src/techlab/code/core/expr/expr_list.dart';

part 'src/techlab/code/core/expr/function-call.dart';

part 'src/techlab/code/core/expr/group_expr.dart';

part 'src/techlab/code/core/expr/literal/array-literal.dart';

part 'src/techlab/code/core/expr/literal/boolean-literal.dart';

part 'src/techlab/code/core/expr/literal/char-literal.dart';

part 'src/techlab/code/core/expr/literal/list-literal.dart';

part 'src/techlab/code/core/expr/literal/map-literal.dart';

part 'src/techlab/code/core/expr/literal/null-literal.dart';

part 'src/techlab/code/core/expr/literal/numeric-literal.dart';

part 'src/techlab/code/core/expr/literal/set_literal.dart';

part 'src/techlab/code/core/expr/literal/string-literal.dart';

part 'src/techlab/code/core/expr/spread.dart';

part 'src/techlab/code/core/extension/extension-list.dart';

part 'src/techlab/code/core/extension/extension-name.dart';

part 'src/techlab/code/core/extension/extension.dart';

part 'src/techlab/code/core/field/field-list.dart';

part 'src/techlab/code/core/field/field-name.dart';

part 'src/techlab/code/core/field/field.dart';

part 'src/techlab/code/core/file.dart';

part 'src/techlab/code/core/function/function-list.dart';

part 'src/techlab/code/core/function/function-name.dart';

part 'src/techlab/code/core/function/function-return-list.dart';

part 'src/techlab/code/core/function/function-return.dart';

part 'src/techlab/code/core/function/function-throw-list.dart';

part 'src/techlab/code/core/function/function-throw.dart';

part 'src/techlab/code/core/function/function.dart';

part 'src/techlab/code/core/generic/generic-param-list.dart';

part 'src/techlab/code/core/generic/generic-param.dart';

part 'src/techlab/code/core/import/import-list.dart';

part 'src/techlab/code/core/import/import-type.dart';

part 'src/techlab/code/core/import/import.dart';

part 'src/techlab/code/core/interface/interface-list.dart';

part 'src/techlab/code/core/interface/interface.dart';

part 'src/techlab/code/core/lambda/lambda.dart';

part 'src/techlab/code/core/mixin/mixin-list.dart';

part 'src/techlab/code/core/mixin/mixin-name.dart';

part 'src/techlab/code/core/mixin/mixin.dart';

part 'src/techlab/code/core/modifier.dart';

part 'src/techlab/code/core/mustache.dart';

part 'src/techlab/code/core/package/package-name.dart';

part 'src/techlab/code/core/package/package.dart';

part 'src/techlab/code/core/place_holder.dart';

part 'src/techlab/code/core/property/property-getter.dart';

part 'src/techlab/code/core/property/property-list.dart';

part 'src/techlab/code/core/property/property-name.dart';

part 'src/techlab/code/core/property/property-setter.dart';

part 'src/techlab/code/core/property/property.dart';

part 'src/techlab/code/core/space.dart';

part 'src/techlab/code/core/statement/case.dart';

part 'src/techlab/code/core/statement/else-if.dart';

part 'src/techlab/code/core/statement/for-each.dart';

part 'src/techlab/code/core/statement/for.dart';

part 'src/techlab/code/core/statement/if.dart';

part 'src/techlab/code/core/statement/ref.dart';

part 'src/techlab/code/core/statement/repeat.dart';

part 'src/techlab/code/core/statement/return.dart';

part 'src/techlab/code/core/statement/statement-list.dart';

part 'src/techlab/code/core/statement/statement.dart';

part 'src/techlab/code/core/statement/var-name.dart';

part 'src/techlab/code/core/statement/var.dart';

part 'src/techlab/code/core/statement/while.dart';

part 'src/techlab/code/core/syntax.dart';

part 'src/techlab/code/core/type/type-list.dart';

part 'src/techlab/code/core/type/type-name.dart';

part 'src/techlab/code/core/type/type.dart';

part 'src/techlab/code/language/oop/oop.dart';

part 'src/techlab/container.dart';

part 'src/techlab/context.dart';

part 'src/techlab/mustache.dart';

part 'src/techlab/node.dart';

part 'src/techlab/output/console.dart';

part 'src/techlab/output/directory.dart';

part 'src/techlab/output/dot-keep-file.dart';

part 'src/techlab/output/glob.dart';

part 'src/techlab/output/file.dart';

part 'src/techlab/prompt/promp_yes_to_all.dart';

part 'src/techlab/output/output-redirect.dart';

part 'src/techlab/output/partial_file.dart';

part 'src/techlab/program.dart';

part 'src/techlab/project.dart';

part 'src/techlab/prompt/prompt.dart';

part 'src/techlab/prompt/prompt_bool.dart';

part 'src/techlab/prompt/prompt_choose.dart';

part 'src/techlab/prompt/prompt_choose_util.dart';

part 'src/techlab/prompt/prompt_int.dart';

part 'src/techlab/prompt/prompt_loop.dart';

part 'src/techlab/prompt/prompt_result.dart';

part 'src/techlab/prompt/prompt_string.dart';

part 'src/techlab/text/indent.dart';

part 'src/techlab/text/join.dart';

part 'src/techlab/text/pad.dart';

part 'src/techlab/text/read_file.dart';

part 'src/techlab/text/text.dart';

part 'src/techlab/text/text_blend.dart';

part 'src/techlab/text/text_merge.dart';

part 'src/techlab/text/text_partial.dart';

part 'src/techlab/text/text_replace.dart';

part 'src/techlab/text/text_transform.dart';

part 'src/techlab/text/trim.dart';
