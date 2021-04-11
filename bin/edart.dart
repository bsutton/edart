// @dart = 2.10

import 'dart:io';

import 'package:args/args.dart';
import 'package:edart/edart_compiler.dart';
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
  var outfile = '$infile.g.dart';
  if (rest.length > 1) {
    outfile = rest[1];
  }

  final file = File(infile);
  if (!file.existsSync()) {
    print('File not found: $infile');
    exit(-1);
  }

  final text = file.readAsStringSync();
  final classname = _path.basename(infile).replaceAll('.', '_');
  final compiler = EdartCompiler();
  final code =
      compiler.compile(classname: classname, filename: infile, source: text);
  File(outfile).writeAsStringSync(code);
}
