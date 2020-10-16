// ignore: unused_import
import 'dart:convert';

class footer_html {
  String render() {
    final out = StringBuffer();
    // ignore: unused_element
    String _$e(v) => const HtmlEscape().convert(v.toString());
    out.write('<footer class="w3-center">\n');
    out.write('    Copyright 2000 - ');
    out.write(_$e(DateTime.now().year));
    out.write('\n');
    out.write('</footer>');
    return out.toString();
  }
}
