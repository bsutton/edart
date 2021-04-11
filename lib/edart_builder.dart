// @dart = 2.10

import 'package:build/build.dart';
import 'package:edart/edart_compiler.dart';
import 'package:path/path.dart' as _path;

Builder edartBuilder(BuilderOptions options) => EdartBuilder();

class EdartBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        '': ['.g.dart']
      };

  @override
  Future build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;
    final extension = _path.extension(inputId.path);
    final outputId = buildStep.inputId.changeExtension('${extension}.g.dart');
    final source = await buildStep.readAsString(inputId);
    final compiler = EdartCompiler();
    final path = inputId.path;
    final classname = _path.basename(path).replaceAll('.', '_');
    final code =
        compiler.compile(classname: classname, filename: path, source: source);
    await buildStep.writeAsString(outputId, code);
  }
}
