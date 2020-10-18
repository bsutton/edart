# edart  
=======

Embedded Dart template engine and compiler. Compiles templates to Dart source code.

Version: 0.1.4

### Warning

*This software is under development.*  

### About

`Edart` is a templating engine and compiler. The template is compiled into native Dart code.  
The main feature of the template engine is that it can contain Dart source code and, as a result, the entire template will be compiled into Dart source code.  
This feature can be called embedded Dart.

`Edart` can be used to generate text files, but the main purpose is for use in web server implementations.  
It allows you to separate the controller and the view and at the same time does not limit the possibilities for the implementation of the view.  
You can implement the view as you see fit and appropriate for your application. No coding or implementation conventions (except using template tags).  
This is an advantage and a disadvantage at the same time.

### Cons

- Doesn't contain built-in support for features such as layouts, blocks, includes etc
- Requires compilation of templates before use
- Not very graceful

### Pros

- Allows to implement such features as layouts, blocks, includes etc in any convenient way
- Templates are compiled to Dart source code
- Doesn't use reflection
- Fast execution of templates
- Simple and straightforward syntax

### Concept

Everything in the template is text except what's included in the template tags.  
Four kinds of opening tags are supported.

- `<%` Embedded source code
- `<%=` An expression whose value will be escaped (using html escape)
- `<%==` An expression whose value will be output as is (no escaping)
- `<%@` Compiler directive

The sequence of characters `%>` is used as the closing tag.

### Tags

The `<%` tag is used to add (embed) source code to the template (to the template source code).  
Preceding spaces before the opening tag `<%` will be removed.  
If a `newline` immediately follows the closing tag `%>`, a `newline` will be removed.

```html
<%
final layout = layout_html();
layout.title = 'Products';
layout.addMeta({'description': 'MegaSuperShop cool price list'});
layout.render(out, request);
%>
```

The `<%=` tag is used to output the value of an expression to a template.  
The expression value will be escaped (html escape).

```html
<%= product.name %>
```

The `<%==` tag is used to output the value of an expression to a template.  
The value of the expression will be output as is (no escaping).

```html
<%== getCssClass(item, active) %>
```

The `<%@` tag is used to specify template compiler directives.  
Preceding spaces before the opening tag `<%@` will be removed.  
If a `newline` immediately follows the closing tag `%>`, a `newline` will be removed.

Template compiler directive format:

`<%@ directive option1="value1" option2="value2" %>`

```html
<%@` import uri="dart:collection" %>
```

### Compiler directives

List of compiler directives (in the form of a name and a list of arguments):

- export: as, hide, show, uri
- import: as, hide, show, uri
- class: extends, implements, mixins, name
- render: name, params

The `import` and `export` directives are used for import and export and follow the same Dart language directives.  
They support the following options: `as`, `hide`, `show` and `uri`.

```html
<%@ import uri="package:path/path.dart" as="_path" %>
<%@ import uri="foo.dart" show="Bar" hide="Baz" %>
<%@ export uri="../view.dart" %>
```

The `class` directive is used to specify a template class name and class inheritance options.  
The class name can be specified via the `name` option.  
Supported class inheritance options include `extends`, `implements`, `mixins`.

```html
<%@ class extends="View" %>
```

The render directive is used to specify the name of the render method and its parameters.  
The method name can be specified via the `name` option.  
The method parameters can be specified via the `params` option.  

```html
<%@ render params="List<Product> products, HttpRequest request" %>
```

### Usage

Compiler activation.

`dart pub global activate edart`

Compiling the template

`dart pub global run edart infile outfile`

Compiling the template via Dart scrpt (example).

```dart
import 'dart:io';

import 'package:edart/edart_compiler.dart';
import 'package:path/path.dart' as _path;

Future<void> build(List<String> files) async {
  for (final path in files) {
    final file = File(path);
    final source = file.readAsStringSync();
    final classname = _path.basename(path).replaceAll('.', '_');
    final compiler = EdartCompiler();
    final code =
        compiler.compile(classname: classname, filename: path, source: source);
    File(path + '.g.dart').writeAsStringSync(code);
  }
}


```

Also possible to compile the templates via `build_runner`

### Examples

`example/views/nav.html`

```html
<%@ import uri="dart:io" %>
<%@ import uri="../site/site_menu.dart" %>
<%@ render params="HttpRequest request" %>
<div class="w3-bar w3-black">
    <%
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
    for (final item in menu.items) { %>
    <a href="<%== item.url %>" class="<%== getClass(item, active) %>">
        <%= item.name %>
    </a>
    <% } %>
</div>
```

`example/views/layout.html`

```html
<%@ import uri="../html/layout.dart" %>
<%@ import uri="breadcrumbs.html.g.dart" %>
<%@ import uri="footer.html.g.dart" %>
<%@ import uri="header.html.g.dart" %>
<%@ import uri="nav.html.g.dart" %>
<%@ export uri="../html/breadcrumb.dart" %>
<%@ export uri="../html/html_utils.dart" %>
<%@ export uri="../html/view.dart" %>
<%@ class extends="Layout" %>
<%@ render params="StringBuffer body, HttpRequest request, {int statusCode: 400}" %>
<html>

<head>
  <title><%= title %></title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <% for (final tag in tags) { %>
  <%== tag %>
  <% } %>
</head>

<body>
  <%== header_html().render(title) %>

  <%== nav_html().render(request) %>

  <div class="w3-container">
    <%== breadcrumbs_html().render(breadcrumbs) %>
  </div>

  <div class="w3-container">
    <%== body %>
  </div>

  <%== footer_html().render() %>

</body>

</html>
<%
body.clear();
body.write(out);
final response = request.response;
response.headers.add('Content-Type', 'text/html; charset=utf-8');
response.statusCode = statusCode;
response.write(out);
%>
```

`example/views/products_index.html`

```html
<%@ import uri="layout.html.g.dart" %>
<%@ import uri="../models/product.dart" %>
<%@ class extends="View" %>
<%@ render params="List<Product> products, HttpRequest request" %>
<p>
    Our cool products list
</p>
<ul class="w3-ul">
    <% for (final product in products) { %>
    <li><%= product.name %>&nbsp;<%= product.price %></li><%
    } %>
</ul>
<%
final layout = layout_html();
layout.title = 'Products';
layout.addTag(HtmlTag('meta', {'description': 'MegaSuperShop cool price list'}));
layout.addBreadcrumb('Products', request.requestedUri.toString());
layout.render(out, request);
%>
```
