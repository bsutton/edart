// ignore: unused_import
import 'dart:convert';
import 'layout.html.g.dart';

class home_index_html extends View {
  String render(HttpRequest request) {
    final out = StringBuffer();
    out.write('<p>\n');
    out.write('    <a href="');
    out.write(htmlEscape.convert('${SiteLinks.productsIndex}'));
    out.write('">View our cool products</a>\n');
    out.write('</p>\n');
    final layout = layout_html();
    layout.title = 'Home page';
    layout.addTag(
        HtmlTag('meta', {'description': 'MegaSuperShop cool price list'}));
    layout.render(out, request);
    return out.toString();
  }
}
