import 'dart:io';

import 'package:args/args.dart';
import 'package:edart/edart_compiler.dart';
import 'package:edart/edart_parser.dart';
import 'package:edart/fragment.dart';
import 'package:path/path.dart' as _path;

Future<void> main(List<String> args) async {
  final argParser = ArgParser();
  final argResults = argParser.parse(args);
  final rest = argResults.rest;
  if (rest.isEmpty) {
    print('Usage: edart [options] infile [outfile]');
    print('${argParser.usage}');
    exit(-1);
  }

  final infile = rest[0];
  var outfile = '$infile.dart';
  if (rest.length > 1) {
    outfile = rest[1];
  }

  final file = File(infile);
  if (!file.existsSync()) {
    print('File not found: $infile');
    exit(-1);
  }

  final text = file.readAsStringSync();
  final parser = EdartParser();
  final fragments = parser.parse(text) as List<Fragment>;
  if (parser.error != null) {
    print(parser.error);
    exit(-1);
  }

  for (final f in fragments) {
    print(f.type);
    print(f.source);
  }

  final classname = _path.basename(infile).replaceAll('.', '_');
  final compiler = EdartCompiler();
  final code = compiler.compile(infile, classname, fragments);
  File(outfile).writeAsStringSync(code);
}
