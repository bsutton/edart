// ignore: unused_import
import 'dart:convert';
import 'layout.html.g.dart';

class home_html extends View {
  String render(HttpRequest request) {
    final out = StringBuffer();
    out.write('<h1>\n');
    out.write('    Mega super shop\n');
    out.write('</h1>\n');
    out.write('<p>\n');
    out.write('    <a href="');
    out.write(htmlEscape.convert('${SiteLinks.products}'));
    out.write('">View our price list</a>\n');
    out.write('</p>\n');
    final layout = layout_html();
    layout.title = 'Home page';
    layout.addMeta({'name': 'description', 'content': 'Mega super shop'});
    layout.render(out, request);
    return out.toString();
  }
}
