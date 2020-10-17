import 'dart:collection';

import 'package:code_builder/code_builder.dart' as _cb;
import 'package:dart_style/dart_style.dart';
import 'package:edart/edart_parser.dart';
import 'package:edart/fragment.dart';

import 'package:meta/meta.dart';

class EdartCompiler {
  String compile(
      {@required String classname,
      @required String filename,
      @required String source}) {
    if (classname == null) {
      throw ArgumentError.notNull('classname');
    }

    if (filename == null) {
      throw ArgumentError.notNull('filename');
    }

    if (source == null) {
      throw ArgumentError.notNull('source');
    }

    final parser = EdartParser();
    final fragments = parser.parse(source) as List<Fragment>;
    if (parser.error != null) {
      throw parser.error;
    }

    final result = compileFragments(
        classname: classname, filename: filename, fragments: fragments);
    return result;
  }

  String compileFragments(
      {@required String classname,
      @required String filename,
      @required List<Fragment> fragments}) {
    if (classname == null) {
      throw ArgumentError.notNull('classname');
    }

    if (fragments == null) {
      throw ArgumentError.notNull('fragments');
    }

    if (filename == null) {
      throw ArgumentError.notNull('filename');
    }

    fragments = _prepare(fragments);
    final classOptions = {'name': classname};
    final renderOptions = {'name': 'render'};
    final code = StringBuffer();
    code.writeln('// ignore: unused_import');
    code.writeln('import \'dart:convert\';');
    for (final fragment
        in fragments.where((e) => e.type == FragmentType.directive)) {
      final directive = fragment.directive;
      final attributes = <String, String>{};
      directive.attributes?.forEach((e) {
        attributes[e.name] = e.value;
      });

      final keys = <String>[];
      Map<String, String> options;
      switch (directive.name) {
        case 'class':
          keys.addAll(['extends', 'implements', 'mixins', 'name']);
          options = classOptions;
          break;
        case 'export':
        case 'import':
          keys.addAll(['as', 'hide', 'show', 'uri']);
          code.write(directive.name);
          code.write(' \'');
          code.write(attributes['uri']);
          code.write('\'');
          if (attributes.containsKey('as')) {
            code.write(' as ');
            code.write(attributes['as']);
          }

          if (attributes.containsKey('show')) {
            code.write(' show ');
            code.write(attributes['show']);
          }

          if (attributes.containsKey('hide')) {
            code.write(' hide ');
            code.write(attributes['hide']);
          }

          code.writeln(';');
          break;
        case 'render':
          keys.addAll(['name', 'params']);
          options = renderOptions;
          break;
        default:
          throw FormatException('Unknown directive: ${directive.name}');
      }

      for (final key in attributes.keys) {
        if (!keys.contains(key)) {
          throw FormatException(
              'Unknown attribute "${key}" in directive "${directive.name}"');
        }

        if (options != null) {
          options[key] = attributes[key];
        }
      }
    }

    code.writeln();
    code.write('class ');
    code.write(classOptions['name']);
    if (classOptions.containsKey('extends')) {
      code.write(' extends ');
      code.write(classOptions['extends']);
    }

    if (classOptions.containsKey('mixins')) {
      code.write(' with ');
      code.write(classOptions['mixins']);
    }

    if (classOptions.containsKey('implements')) {
      code.write(' implements ');
      code.write(classOptions['implements']);
    }

    code.writeln(' {');
    //
    code.write('String ');
    code.write(renderOptions['name']);
    code.write('(');
    if (renderOptions.containsKey('params')) {
      code.write(renderOptions['params']);
    }

    code.writeln(') {');
    code.writeln('final out = StringBuffer();');
    for (final fragment in fragments) {
      final source = fragment.source;
      switch (fragment.type) {
        case FragmentType.code:
          code.writeln(source.trim());
          break;
        case FragmentType.expression:
          final expression = source.trim();
          if (expression.isNotEmpty) {
            code.write('out.write(');
            code.write('htmlEscape.convert(\'\${');
            code.write(expression);
            code.writeln('}\'));');
          }

          break;
        case FragmentType.raw:
          code.write('out.write(');
          code.write(source.trim());
          code.writeln(');');
          break;
        case FragmentType.text:
          code.write('out.write(');
          code.write(_literal(source));
          code.writeln(');');
          break;
        default:
      }
    }

    code.writeln('return out.toString();');
    code.write('}');

    code.write('}');
    var result = code.toString();
    try {
      result = DartFormatter().format(result);
    } catch (e) {
      print('Formatting error: $filename');
    }

    return result;
  }

  String _literal(String value) {
    final emitter = _cb.DartEmitter();
    return _cb.literal(value).accept(emitter).toString();
  }

  List<Fragment> _prepare(List<Fragment> fragments) {
    final list = LinkedList<_LinkedListEntry<Fragment>>();
    for (final fragment in fragments) {
      final entry = _LinkedListEntry(fragment);
      list.add(entry);
    }

    bool isNewLine(String text) {
      return text == '\n' || text == '\r\n';
    }

    bool isWhite(String text) {
      final codeUnits = text.codeUnits;
      final count = codeUnits.takeWhile((e) => e == 32).length;
      return codeUnits.length == count;
    }

    var current = list.first;
    while (current != null) {
      final fragment = current.value;
      switch (fragment.type) {
        case FragmentType.code:
        case FragmentType.directive:
          final previous = current.previous;
          if (previous != null) {
            final fragment2 = previous.value;
            if (fragment2.type == FragmentType.text) {
              if (isWhite(fragment2.source)) {
                list.remove(previous);
              }
            }
          }

          final next = current.next;
          if (next != null) {
            final fragment2 = next.value;
            if (fragment2.type == FragmentType.text) {
              if (isNewLine(fragment2.source)) {
                list.remove(next);
              }
            }
          }

          break;
        case FragmentType.expression:
        case FragmentType.raw:
        case FragmentType.text:
          break;
      }

      current = current.next;
    }

    final result = list.map((e) => e.value).toList();
    return result;
  }
}

class _LinkedListEntry<T> extends LinkedListEntry<_LinkedListEntry<T>> {
  final T value;

  _LinkedListEntry(this.value);
}
