import 'dart:io';

import 'package:edart/edart_parser.dart';
import 'package:edart/fragment.dart';
import 'package:path/path.dart' as _path;

import 'package:edart/edart_compiler.dart';

Future<void> build(List<String> files) async {
  for (final path in files) {
    final file = File(path);
    final source = file.readAsStringSync();
    final parser = EdartParser();
    final fragments = parser.parse(source) as List<Fragment>;
    if (parser.error != null) {
      throw parser.error;
    }

    final classname = _path.basename(path).replaceAll('.', '_');
    final compiler = EdartCompiler();
    final code = compiler.compile(path, classname, fragments);
    File(path + '.g.dart').writeAsStringSync(code);
  }
}
