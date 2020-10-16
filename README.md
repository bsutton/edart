# edart  
=======

Embedded Dart template engine and compiler.

Version: 0.0.1

### Warning

*This software is under development.*  
*Support for a typical build system for Dart (build_runner) will be added in the near future.*

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
Any leading spaces from the beginning of the line before the opening tag `<%` will be removed.  
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
Any leading spaces from the beginning of the line before the opening tag `<%@` will be removed.  
If a `newline` immediately follows the closing tag `%>`, a `newline` will be removed.

Template compiler directive format.  
`<%@ directive option1="value1" option2="value2" %>`

```html
<%@` import uri="dart:collection" %>
```

### Compiler directives

List of compiler directives (in the form of a name and a list of arguments):

- export: as, hide, show, uri
- import: as, hide, show, uri
- class: extends, implemwnts, mixins, name
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

To be continued...