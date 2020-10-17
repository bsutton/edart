import 'breadcrumb.dart';

export 'dart:io';

export 'html_utils.dart';
export 'site_links.dart';

class Layout {
  final breadcrumbs = <Breadcrumb>[];

  final metas = <Map<String, String>>[];

  String title = '';

  void addBreadcrumb(String text, String url) {
    final item = Breadcrumb(text: text, url: url);

    breadcrumbs.add(item);
  }

  void addMeta(Map<String, String> item) {
    metas.add(item);
  }
}
