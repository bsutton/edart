// ignore: unused_import
import 'dart:convert';
import 'dart:io';
import '../site_menu.dart';

class nav_html {
  String render(HttpRequest request) {
    final out = StringBuffer();
    out.write('<div class="w3-bar w3-black">\n');
    final url = request.requestedUri.path;
    String getClass(MenuItem item, MenuItem active) {
      final result = ['w3-bar-item', 'w3-button'];
      if (item == active) {
        result.add('w3-red');
      }
      return result.join(' ');
    }

    final menu = Menu.main;
    final active = menu.findActive(url);
    for (final item in menu.items) {
      out.write('    <a href="');
      out.write(item.url);
      out.write('" class="');
      out.write(getClass(item, active));
      out.write('">\n');
      out.write('        ');
      out.write(htmlEscape.convert('${item.name}'));
      out.write('\n');
      out.write('    </a>\n');
    }
    out.write('</div>');
    return out.toString();
  }
}
