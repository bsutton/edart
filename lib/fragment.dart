class Attribute {
  final String name;

  final String value;

  Attribute(this.name, this.value);
}

class Directive {
  final String name;

  final List<Attribute> attributes;

  Directive(this.name, this.attributes);
}

class Fragment {
  final Directive directive;

  final String source;

  final FragmentType type;

  Fragment({this.directive, this.source, this.type});

  Fragment.code(this.source)
      : directive = null,
        type = FragmentType.code;

  Fragment.directive(this.directive)
      : source = null,
        type = FragmentType.directive;

  Fragment.expression(this.source)
      : directive = null,
        type = FragmentType.expression;

  Fragment.raw(this.source)
      : directive = null,
        type = FragmentType.raw;

  Fragment.text(this.source)
      : directive = null,
        type = FragmentType.text;
}

enum FragmentType { code, expression, directive, raw, text }
