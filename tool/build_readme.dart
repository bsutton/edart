import 'build.dart';

Future<void> main(List<String> args) async {
  final files = ['tool/readme_md'];
  await build(files);
}
