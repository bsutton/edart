// ignore: unused_import
import 'dart:convert';

class footer_html {
  String render() {
    final out = StringBuffer();
    out.write('<footer class="w3-center">\n');
    out.write('    Copyright 2000 - ');
    out.write(htmlEscape.convert('${DateTime.now().year}'));
    out.write('\n');
    out.write('</footer>');
    return out.toString();
  }
}
