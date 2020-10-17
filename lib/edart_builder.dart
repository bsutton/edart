import 'package:build/build.dart';
import 'package:edart/edart_compiler.dart';
import 'package:edart/edart_parser.dart';
import 'package:edart/fragment.dart';
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
    final data = await buildStep.readAsString(inputId);
    final parser = EdartParser();
    final fragments = parser.parse(data) as List<Fragment>;
    if (parser.error != null) {
      throw parser.error;
    }

    final compiler = EdartCompiler();
    final path = inputId.path;
    final classname = _path.basename(path).replaceAll('.', '_');
    final code = compiler.compile(path, classname, fragments);
    await buildStep.writeAsString(outputId, code);
  }
}
