export 'dart:io';

export '../site_links.dart';
export 'html_utils.dart';

class Layout {
  final metas = <Map<String, String>>[];

  String title = '';

  void addMeta(Map<String, String> meta) {
    metas.add(meta);
  }
}
