// ignore: unused_import
import 'dart:convert';
import 'layout.dart';
import 'header.html.g.dart';
import 'footer.html.g.dart';
import 'nav.html.g.dart';
export 'view.dart';

class layout_html extends Layout {
  String render(StringBuffer body, HttpRequest request) {
    final out = StringBuffer();
    // ignore: unused_element
    String _$e(v) => const HtmlEscape().convert(v.toString());
    out.write('<html>\n');
    out.write('\n');
    out.write('<head>\n');
    out.write('    <title>');
    out.write(_$e(title));
    out.write('</title>\n');
    for (final meta in metas) {
      out.write('    <meta ');
      out.write(_$e(HtmlUtils.attrs(meta)));
      out.write(' />\n');
    }
    out.write(
        '    <meta name="viewport" content="width=device-width, initial-scale=1">\n');
    out.write(
        '    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">\n');
    out.write('</head>\n');
    out.write('\n');
    out.write('<body>\n');
    out.write(header_html().render(title));
    out.write('\n');
    out.write(nav_html().render(request));
    out.write('\n');
    out.write('    <div class="w3-container">\n');
    out.write('        ');
    out.write(body);
    out.write('\n');
    out.write('    </div>\n');
    out.write('\n');
    out.write(footer_html().render());
    out.write('\n');
    out.write('</body>\n');
    out.write('\n');
    out.write('</html>\n');
    body.clear();
    body.write(out);
    final response = request.response;
    response.headers.add('Content-Type', 'text/html; charset=utf-8');
    response.statusCode = 400;
    response.write(out);
    return out.toString();
  }
}
