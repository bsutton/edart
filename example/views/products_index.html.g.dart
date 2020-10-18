// ignore: unused_import
import 'dart:convert';
import 'layout.html.g.dart';
import '../models/product.dart';

class products_index_html extends View {
  String render(List<Product> products, HttpRequest request) {
    final out = StringBuffer();
    out.write('<p>\n');
    out.write('    Our cool products list\n');
    out.write('</p>\n');
    out.write('<ul class="w3-ul">\n');
    for (final product in products) {
      out.write('    <li>');
      out.write(htmlEscape.convert('${product.name}'));
      out.write('&nbsp;');
      out.write(htmlEscape.convert('${product.price}'));
      out.write('</li>');
    }
    out.write('</ul>\n');
    final layout = layout_html();
    layout.title = 'Products';
    layout.addTag(
        HtmlTag('meta', {'description': 'MegaSuperShop cool price list'}));
    layout.addBreadcrumb('Products', request.requestedUri.toString());
    layout.render(out, request);
    return out.toString();
  }
}
