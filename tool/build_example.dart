// @dart = 2.10

import 'dart:io';

import 'package:path/path.dart' as _path;

import 'build.dart';

Future<void> main() async {
  final files = <String>[];
  final list = Directory('example/views').listSync();
  for (final entry in list) {
    if (entry.statSync().type == FileSystemEntityType.file) {
      final path = entry.path;
      final extension = _path.extension(path);
      if (extension == '.html') {
        files.add(path);
      }
    }
  }

  await build(files);
}
