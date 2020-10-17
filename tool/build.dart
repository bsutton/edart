import 'dart:io';

import 'package:edart/edart_compiler.dart';
import 'package:path/path.dart' as _path;

Future<void> build(List<String> files) async {
  for (final path in files) {
    final file = File(path);
    final source = file.readAsStringSync();
    final classname = _path.basename(path).replaceAll('.', '_');
    final compiler = EdartCompiler();
    final code =
        compiler.compile(classname: classname, filename: path, source: source);
    File(path + '.g.dart').writeAsStringSync(code);
  }
}
