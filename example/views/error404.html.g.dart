// ignore: unused_import
import 'dart:convert';
import 'layout.html.g.dart';

class error404_html {
  String render(HttpRequest request) {
    final out = StringBuffer();
    out.write('<h1>\n');
    out.write('    Error 404\n');
    out.write('</h1>\n');
    out.write('<p>\n');
    out.write('    Page not found\n');
    out.write('</p>\n');
    final layout = layout_html();
    layout.addMeta({'name': 'description', 'content': 'Error 404'});
    layout.render(out, request, statusCode: 404);
    return out.toString();
  }
}
