import 'breadcrumb.dart';
import 'html_tag.dart';

export 'dart:io';

export '../site/site_links.dart';
export 'html_utils.dart';

class Layout {
  final breadcrumbs = <Breadcrumb>[];

  final tags = <HtmlTag>[];

  String title = '';

  void addBreadcrumb(String text, String url) {
    final item = Breadcrumb(text: text, url: url);

    breadcrumbs.add(item);
  }

  HtmlTag addTag(String name, [Map<String, String> attributes]) {
    final tag = HtmlTag(name, attributes);
    tags.add(tag);
    return tag;
  }
}
