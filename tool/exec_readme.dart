import 'dart:io';

import 'package:pubspec_parse/pubspec_parse.dart';

import 'readme.g.dart';

Future<void> main(List<String> args) async {
  final yaml = File('pubspec.yaml').readAsStringSync();
  final pubspec = Pubspec.parse(yaml);
  final t = readme();
  final r = t.render(pubspec);
  File('README.md').writeAsStringSync(r);
}
