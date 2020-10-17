// ignore: unused_import
import 'dart:convert';

class header_html {
  String render(String title) {
    final out = StringBuffer();
    out.write('<header class="w3-container w3-teal">\n');
    out.write('    <h1>');
    out.write(htmlEscape.convert('${title}'));
    out.write('</h1>\n');
    out.write('</header>');
    return out.toString();
  }
}
