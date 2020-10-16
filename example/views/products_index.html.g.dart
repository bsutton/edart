// ignore: unused_import
import 'dart:convert';
import 'layout.html.g.dart';
import '../models/product.dart';

class products_index_html extends View {
  String render(List<Product> products, HttpRequest request) {
    final out = StringBuffer();
    // ignore: unused_element
    String _$e(v) => const HtmlEscape().convert(v.toString());
    out.write('<p>\n');
    out.write('    Our cool products list\n');
    out.write('</p>\n');
    out.write('<ul class="w3-ul">\n');
    for (final product in products) {
      out.write('    <li>');
      out.write(_$e(product.name));
      out.write('&nbsp;');
      out.write(_$e(product.price));
      out.write('</li>\n');
    }
    out.write('</ul>\n');
    final layout = layout_html();
    layout.title = 'Products';
    layout.addMeta({'description': 'MegaSuperShop cool price list'});
    layout.render(out, request);
    return out.toString();
  }
}
