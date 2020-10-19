import 'dart:convert';

class HtmlTag {
  final Map<String, String> attributes = {};

  String content;

  final String name;

  HtmlTag(this.name, [Map<String, String> attributes, this.content]) {
    if (attributes != null) {
      this.attributes.addAll(attributes);
    }

    content ??= '';
    final elemEscape = HtmlEscape(HtmlEscapeMode.element);
    content = elemEscape.convert(content);
  }

  @override
  String toString() {
    final sb = StringBuffer();
    sb.write('<');
    sb.write(name);
    if (attributes.isNotEmpty) {
      sb.write(' ');
      sb.write(HtmlUtils.attrs(attributes));
    }

    if (content.isEmpty) {
      sb.write('>');
    } else {
      sb.write('>');
      sb.write(content);
      sb.write('<');
      sb.write(name);
      sb.write('/>');
    }

    return sb.toString();
  }
}

class HtmlUtils {
  static String attrs(Map<String, String> attributes) {
    final attrEscape = HtmlEscape(HtmlEscapeMode.attribute);
    final sb = StringBuffer();
    for (final key in attributes.keys) {
      sb.write(key);
      sb.write('="');
      var value = attributes[key];
      value = attrEscape.convert(value);
      sb.write(value);
      sb.write('"');
    }

    return sb.toString();
  }

  static String href(String url, [Map<String, dynamic> attributes]) {
    attributes ??= {};
    final sb = StringBuffer();
    sb.write(url);
    final params = <String>[];
    for (final key in attributes.keys) {
      final value = attributes[key];
      if (value != null) {
        params.add('?${key}=${value}');
      } else {
        params.add('?${key}');
      }
    }

    sb.write(params.join('&'));
    return sb.toString();
  }
}
