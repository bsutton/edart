// ignore: unused_import
import 'dart:convert';
import '../html/layout.dart';
import 'breadcrumbs.html.g.dart';
import 'footer.html.g.dart';
import 'header.html.g.dart';
import 'nav.html.g.dart';
export '../html/breadcrumb.dart';
export '../html/html_utils.dart';
export '../html/view.dart';

class layout_html extends Layout {
  String render(StringBuffer body, HttpRequest request, {int statusCode: 400}) {
    final out = StringBuffer();
    out.write('<html>\n');
    out.write('\n');
    out.write('<head>\n');
    out.write('  <title>');
    out.write(htmlEscape.convert('${title}'));
    out.write('</title>\n');
    out.write(
        '  <meta name="viewport" content="width=device-width, initial-scale=1">\n');
    out.write(
        '  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">\n');
    for (final tag in tags) {
      out.write('  ');
      out.write(tag);
      out.write('\n');
    }
    out.write('</head>\n');
    out.write('\n');
    out.write('<body>\n');
    out.write('  ');
    out.write(header_html().render(title));
    out.write('\n');
    out.write('\n');
    out.write('  ');
    out.write(nav_html().render(request));
    out.write('\n');
    out.write('\n');
    out.write('  <div class="w3-container">\n');
    out.write('    ');
    out.write(breadcrumbs_html().render(breadcrumbs));
    out.write('\n');
    out.write('  </div>\n');
    out.write('\n');
    out.write('  <div class="w3-container">\n');
    out.write('    ');
    out.write(body);
    out.write('\n');
    out.write('  </div>\n');
    out.write('\n');
    out.write('  ');
    out.write(footer_html().render());
    out.write('\n');
    out.write('\n');
    out.write('</body>\n');
    out.write('\n');
    out.write('</html>\n');
    body.clear();
    body.write(out);
    final response = request.response;
    response.headers.add('Content-Type', 'text/html; charset=utf-8');
    response.statusCode = statusCode;
    response.write(out);
    return out.toString();
  }
}
