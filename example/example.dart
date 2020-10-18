import 'dart:io';

import 'models/product.dart';
import 'views/error404.html.g.dart';
import 'views/home_index.html.g.dart';
import 'views/products_index.html.g.dart';

Future<void> main() async {
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 8081);
  print('Serve http://localhost:${server.port}');
  server.listen((request) async {
    final response = request.response;
    try {
      await _handle(request);
    } catch (e) {
      response.write(e);
    } finally {
      await response.close();
    }
  });
}

Future<void> _handle(HttpRequest request) async {
  final uri = request.requestedUri;
  switch (uri.path) {
    case '/':
      await _handleHome(request);
      break;
    case '/products':
    case '/products/':
      await _handleProducts(request);
      break;
    default:
      await _handleNotFound(request);
      break;
  }
}

Future<void> _handleHome(HttpRequest request) async {
  final view = home_index_html();
  view.render(request);
}

Future<void> _handleNotFound(HttpRequest request) async {
  final view = error404_html();
  view.render(request);
}

Future<void> _handleProducts(HttpRequest request) async {
  final products = [
    Product('Cool product', 100),
    Product('Very cool product', 200),
    Product('Super cool product', 300),
  ];

  final view = products_index_html();
  view.render(products, request);
}
