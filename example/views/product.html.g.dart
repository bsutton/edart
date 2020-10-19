// ignore: unused_import
import 'dart:convert';
import 'layout.html.g.dart';
import '../models/product.dart';

class product_html extends View {
  String render(Product product, HttpRequest request) {
    final out = StringBuffer();
    out.write('<h1>\n');
    out.write('    ');
    out.write(htmlEscape.convert('${product.name}'));
    out.write('\n');
    out.write('</h1>\n');
    out.write('<ul class="w3-ul">\n');
    out.write('    <li>Name: ');
    out.write(htmlEscape.convert('${product.name}'));
    out.write('</li>\n');
    out.write('    <li>Price: ');
    out.write(htmlEscape.convert('${product.price}'));
    out.write('</li>\n');
    out.write('</ul>\n');
    final layout = layout_html();
    layout.title = product.name;
    layout.addMeta({'name': 'description', 'content': product.name});
    layout.addBreadcrumb('Products', SiteLinks.products);
    layout.addBreadcrumb(
        product.name, HtmlUtils.href(SiteLinks.product, {'id': product.id}));
    layout.render(out, request);
    return out.toString();
  }
}
