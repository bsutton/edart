import 'dart:convert';

class HtmlTag {
  Map<String, String> attributes = {};

  final String name;

  String value = '';

  HtmlTag(this.name, [this.attributes]);

  void setValue(String value, {bool escape = true}) {
    if (escape) {
      value = htmlEscape.convert(value);
    }

    this.value = value;
  }
}
