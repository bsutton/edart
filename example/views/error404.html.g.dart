// ignore: unused_import
import 'dart:convert';
import 'layout.html.g.dart';

class error404_html {
  String render(HttpRequest request) {
    final out = StringBuffer();
    out.write('Page not found\n');
    final layout = layout_html();
    layout.addMeta({'description': 'Error 404'});
    layout.render(out, request);
    return out.toString();
  }
}
