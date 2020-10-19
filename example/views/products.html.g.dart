// ignore: unused_import
import 'dart:convert';
import 'layout.html.g.dart';
import '../models/product.dart';

class products_html extends View {
  String render(List<Product> products, HttpRequest request) {
    final out = StringBuffer();
    out.write('<h1>\n');
    out.write('    Price list\n');
    out.write('</h1>\n');
    if (products.isEmpty) {
      out.write('<p>\n');
      out.write('    No products found\n');
      out.write('</p>\n');
    } else {
      out.write('<table class="w3-table-all">\n');
      out.write('    <tr>\n');
      out.write('        <th>Product</th>\n');
      out.write('        <th>Price</th>\n');
      out.write('    </tr>\n');
      for (final product in products) {
        out.write('    <tr>\n');
        out.write('        <td>\n');
        out.write('            <a href="');
        out.write(htmlEscape.convert(
            '${HtmlUtils.href(SiteLinks.product, {'id': product.id})}'));
        out.write('">\n');
        out.write('                ');
        out.write(htmlEscape.convert('${product.name}'));
        out.write('\n');
        out.write('            </a>\n');
        out.write('        </td>\n');
        out.write('        <td>');
        out.write(htmlEscape.convert('${product.price}'));
        out.write('</td>\n');
        out.write('    </tr>\n');
      }
      out.write('</table>\n');
    }
    final layout = layout_html();
    layout.title = 'Products';
    layout.addMeta({'name': 'description', 'content': 'Price list'});
    layout.addBreadcrumb('Products', SiteLinks.products);
    layout.render(out, request);
    return out.toString();
  }
}
