import 'dart:convert';

class HtmlUtils {
  static String attrs(Map<String, String> attrs) {
    final sb = StringBuffer();
    for (final key in attrs.keys) {
      sb.write(key);
      sb.write('="');
      sb.write(attrs[key]);
      sb.write('"');
    }

    return sb.toString();
  }
}

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
    final attrEscape = HtmlEscape(HtmlEscapeMode.attribute);
    final sb = StringBuffer();
    sb.write('<');
    sb.write(name);
    if (attributes.isNotEmpty) {
      sb.write(' ');
      for (final key in attributes.keys) {
        sb.write(key);
        sb.write('=');
        sb.write('"');
        var value = attributes[key];
        value = attrEscape.convert(value);
        sb.write(value);
        sb.write('"');
      }
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
