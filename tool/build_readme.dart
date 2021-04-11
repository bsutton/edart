// @dart = 2.10

import 'build.dart';

Future<void> main(List<String> args) async {
  final files = ['tool/readme_md'];
  await build(files);
}
