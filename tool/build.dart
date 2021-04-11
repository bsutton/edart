// @dart = 2.10

import 'dart:io';

import 'package:edart/edart_compiler.dart';
import 'package:path/path.dart' as _path;

Future<void> build(List<String> files, {String Function(String) rename}) async {
  rename ??= (String path) => path + '.g.dart';
  for (final path in files) {
    print('Compile template: $path');
    final filename = rename(path);
    final file = File(path);
    final source = file.readAsStringSync();
    final classname = _path.basename(path).replaceAll('.', '_');
    final compiler = EdartCompiler();
    final code =
        compiler.compile(classname: classname, filename: path, source: source);
    File(filename).writeAsStringSync(code);
    print('Compiled to file: $filename');
  }
}
