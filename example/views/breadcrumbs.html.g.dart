// ignore: unused_import
import 'dart:convert';
import '../html/breadcrumb.dart';

class breadcrumbs_html {
  String render(List<Breadcrumb> breadcrumbs) {
    final out = StringBuffer();
    out.write('<p>\n');
    if (breadcrumbs.isNotEmpty) {
      out.write('<a href="/">Home</a>&nbsp;/&nbsp;');
      final last = breadcrumbs.last;
      for (final item in breadcrumbs) {
        if (item != last) {
          out.write('<a href="');
          out.write(item.url);
          out.write('">');
          out.write(htmlEscape.convert('${item.text}'));
          out.write('</a>&nbsp;/&nbsp;');
        } else {
          out.write(htmlEscape.convert('${item.text}'));
        }
      }
    } else {
      out.write('Home');
    }
    out.write('</p>');
    return out.toString();
  }
}
