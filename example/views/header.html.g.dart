// ignore: unused_import
import 'dart:convert';

class header_html {
  String render(String title) {
    final out = StringBuffer();
    // ignore: unused_element
    String _$e(v) => const HtmlEscape().convert(v.toString());
    out.write('<header class="w3-container w3-teal">\n');
    out.write('    <h1>');
    out.write(_$e(title));
    out.write('</h1>\n');
    out.write('</header>');
    return out.toString();
  }
}
