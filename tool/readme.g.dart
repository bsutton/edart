// ignore: unused_import
import 'dart:convert';
import 'dart:io';
import 'package:pubspec_parse/pubspec_parse.dart';

class readme {
  String render(Pubspec pubspec) {
    final out = StringBuffer();
    const tagCod = '<%';
    final tagDir = '<%@';
    final tagExp = '<%=';
    final tagRaw = '<%==';
    final tagEnd = '%' '>';
    out.write('# ');
    out.write(htmlEscape.convert('${pubspec.name}'));
    out.write('  \n');
    out.write('=======\n');
    out.write('\n');
    out.write(htmlEscape.convert('${pubspec.description}'));
    out.write('\n');
    out.write('\n');
    out.write('Version: ');
    out.write(htmlEscape.convert('${pubspec.version}'));
    out.write('\n');
    out.write('\n');
    out.write('### Warning\n');
    out.write('\n');
    out.write('*This software is under development.*  \n');
    out.write('\n');
    out.write('### About\n');
    out.write('\n');
    out.write(
        '`Edart` is a templating engine and compiler. The template is compiled into native Dart code.  \n');
    out.write(
        'The main feature of the template engine is that it can contain Dart source code and, as a result, the entire template will be compiled into Dart source code.  \n');
    out.write('This feature can be called embedded Dart.\n');
    out.write('\n');
    out.write(
        '`Edart` can be used to generate text files, but the main purpose is for use in web server implementations.  \n');
    out.write(
        'It allows you to separate the controller and the view and at the same time does not limit the possibilities for the implementation of the view.  \n');
    out.write(
        'You can implement the view as you see fit and appropriate for your application. No coding or implementation conventions (except using template tags).  \n');
    out.write('This is an advantage and a disadvantage at the same time.\n');
    out.write('\n');
    out.write('### Cons\n');
    out.write('\n');
    out.write(
        '- Doesn\'t contain built-in support for features such as layouts, blocks, includes etc\n');
    out.write('- Requires compilation of templates before use\n');
    out.write('- Not very graceful\n');
    out.write('\n');
    out.write('### Pros\n');
    out.write('\n');
    out.write(
        '- Allows to implement such features as layouts, blocks, includes etc in any convenient way\n');
    out.write('- Allows to redefine the render return value and its type\n');
    out.write('- Templates are compiled to Dart source code\n');
    out.write('- Doesn\'t use reflection\n');
    out.write('- Fast execution of templates\n');
    out.write('- Simple and straightforward syntax\n');
    out.write('\n');
    out.write('### Concept\n');
    out.write('\n');
    out.write(
        'Everything in the template is text except what\'s included in the template tags.  \n');
    out.write('Four kinds of opening tags are supported.\n');
    out.write('\n');
    out.write('- `');
    out.write(tagCod);
    out.write('` Embedded source code\n');
    out.write('- `');
    out.write(tagExp);
    out.write(
        '` An expression whose value will be escaped (using html escape)\n');
    out.write('- `');
    out.write(tagRaw);
    out.write(
        '` An expression whose value will be output as is (no escaping)\n');
    out.write('- `');
    out.write(tagDir);
    out.write('` Compiler directive\n');
    out.write('\n');
    out.write('The sequence of characters `');
    out.write(tagEnd);
    out.write('` is used as the closing tag.\n');
    out.write('\n');
    out.write('### Tags\n');
    out.write('\n');
    out.write('The `');
    out.write(tagCod);
    out.write(
        '` tag is used to add (embed) source code to the template (to the template source code).  \n');
    out.write('Preceding spaces before the opening tag `');
    out.write(tagCod);
    out.write('` will be removed.  \n');
    out.write('If a `newline` immediately follows the closing tag `');
    out.write(tagEnd);
    out.write('`, a `newline` will be removed.\n');
    out.write('\n');
    out.write('```html\n');
    out.write(tagCod);
    out.write('\n');
    out.write('final layout = layout_html();\n');
    out.write('layout.title = \'Products\';\n');
    out.write(
        'layout.addMeta({\'description\': \'MegaSuperShop cool price list\'});\n');
    out.write('layout.render(out, request);\n');
    out.write(tagEnd);
    out.write('\n');
    out.write('```\n');
    out.write('\n');
    out.write('The `');
    out.write(tagExp);
    out.write(
        '` tag is used to output the value of an expression to a template.  \n');
    out.write('The expression value will be escaped (html escape).\n');
    out.write('\n');
    out.write('```html\n');
    out.write(tagExp);
    out.write(' product.name ');
    out.write(tagEnd);
    out.write('\n');
    out.write('```\n');
    out.write('\n');
    out.write('The `');
    out.write(tagRaw);
    out.write(
        '` tag is used to output the value of an expression to a template.  \n');
    out.write(
        'The value of the expression will be output as is (no escaping).\n');
    out.write('\n');
    out.write('```html\n');
    out.write(tagRaw);
    out.write(' getCssClass(item, active) ');
    out.write(tagEnd);
    out.write('\n');
    out.write('```\n');
    out.write('\n');
    out.write('The `');
    out.write(tagDir);
    out.write('` tag is used to specify template compiler directives.  \n');
    out.write('Preceding spaces before the opening tag `');
    out.write(tagDir);
    out.write('` will be removed.  \n');
    out.write('If a `newline` immediately follows the closing tag `');
    out.write(tagEnd);
    out.write('`, a `newline` will be removed.\n');
    out.write('\n');
    out.write('Template compiler directive format:\n');
    out.write('\n');
    out.write('`');
    out.write(tagDir);
    out.write(' directive option1="value1" option2="value2" ');
    out.write(tagEnd);
    out.write('`\n');
    out.write('\n');
    out.write('```html\n');
    out.write(tagDir);
    out.write('` import uri="dart:collection" ');
    out.write(tagEnd);
    out.write('\n');
    out.write('```\n');
    out.write('\n');
    out.write('### Compiler directives\n');
    out.write('\n');
    out.write(
        'List of compiler directives (in the form of a name and a list of arguments):\n');
    out.write('\n');
    out.write('- export: as, hide, show, uri\n');
    out.write('- import: as, hide, show, uri\n');
    out.write('- class: extends, implements, mixins, name\n');
    out.write('- render: name, params\n');
    out.write('\n');
    out.write(
        'The `import` and `export` directives are used for import and export and follow the same Dart language directives.  \n');
    out.write(
        'They support the following options: `as`, `hide`, `show` and `uri`.\n');
    out.write('\n');
    out.write('```html\n');
    out.write(tagDir);
    out.write(' import uri="package:path/path.dart" as="_path" ');
    out.write(tagEnd);
    out.write('\n');
    out.write(tagDir);
    out.write(' import uri="foo.dart" show="Bar" hide="Baz" ');
    out.write(tagEnd);
    out.write('\n');
    out.write(tagDir);
    out.write(' export uri="../view.dart" ');
    out.write(tagEnd);
    out.write('\n');
    out.write('```\n');
    out.write('\n');
    out.write(
        'The `class` directive is used to specify a template class name and class inheritance options.  \n');
    out.write('The class name can be specified via the `name` option.  \n');
    out.write(
        'Supported class inheritance options include `extends`, `implements`, `mixins`.\n');
    out.write('\n');
    out.write('```html\n');
    out.write(tagDir);
    out.write(' class extends="View" ');
    out.write(tagEnd);
    out.write('\n');
    out.write('```\n');
    out.write('\n');
    out.write(
        'The render directive is used to specify the name of the render method and its parameters.  \n');
    out.write('The method name can be specified via the `name` option.  \n');
    out.write(
        'The method parameters can be specified via the `params` option.  \n');
    out.write(
        'The `returns` option allows to change the return value and type.  \n');
    out.write('Default value: `out.toString(): String`.  \n');
    out.write(
        'This is useful if you need to return a result other than a string value.  \n');
    out.write('For example, return a value of type `Response`.  \n');
    out.write('Option `returns` has the following format.\n');
    out.write('\n');
    out.write('`resultExpr: TypeOfResult`\n');
    out.write('\n');
    out.write('```html\n');
    out.write(tagDir);
    out.write(' render params="Request request" ');
    out.write(tagEnd);
    out.write('\n');
    out.write(tagDir);
    out.write(' render returns="response: Response" ');
    out.write(tagEnd);
    out.write('\n');
    out.write(tagCod);
    out.write('\n');
    out.write('// ... some code\n');
    out.write('final content = layout.render(out, request);\n');
    out.write('final response = Response(400, content, headers: headers);\n');
    out.write(tagEnd);
    out.write('\n');
    out.write('```\n');
    out.write('\n');
    out.write('\n');
    out.write('```html\n');
    out.write(tagDir);
    out.write(' render params="List<Product> products, HttpRequest request" ');
    out.write(tagEnd);
    out.write('\n');
    out.write('```\n');
    out.write('\n');
    out.write('### Usage\n');
    out.write('\n');
    out.write('Compiler activation.\n');
    out.write('\n');
    out.write('`dart pub global activate edart`\n');
    out.write('\n');
    out.write('Compiling the template\n');
    out.write('\n');
    out.write('`dart pub global run edart infile outfile`\n');
    out.write('\n');
    out.write('Compiling the template via Dart scrpt (example).\n');
    out.write('\n');
    out.write('```dart\n');
    out.write(File('tool/build.dart').readAsStringSync());
    out.write('\n');
    out.write('\n');
    out.write('```\n');
    out.write('\n');
    out.write('Also possible to compile the templates via `build_runner`\n');
    out.write('\n');
    out.write('### Examples\n');
    final files = [
      'example/views/nav.html',
      'example/views/layout.html',
      'example/views/products_index.html',
    ];
    for (final file in files) {
      out.write('\n');
      out.write('`');
      out.write(file);
      out.write('`\n');
      out.write('\n');
      out.write('```html\n');
      out.write(File(file).readAsStringSync());
      out.write('\n');
      out.write('```\n');
    }
    return out.toString();
  }
}
