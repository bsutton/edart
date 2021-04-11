import 'dart:io';

import 'service/catalog_service.dart';
import 'views/error404.html.g.dart';
import 'views/home.html.g.dart';
import 'views/product.html.g.dart';
import 'views/products.html.g.dart';

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
    case '/product':
    case '/product/':
      await _handleProduct(request);
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
  final view = home_html();
  view.render(request);
}

Future<void> _handleNotFound(HttpRequest request) async {
  final view = error404_html();
  view.render(request);
}

Future<void> _handleProduct(HttpRequest request) async {
  final params = request.uri.queryParameters;
  final id = params['id'];
  if (id == null) {
    await request.response.redirect(Uri.parse('/'));
    return;
  }

  final productId = int.tryParse(id);
  if (productId == null) {
    await request.response.redirect(Uri.parse('/'));
    return;
  }

  final catalog = CatalogService();
  final product = await catalog.getProduct(productId);
  if (product == null) {
    await request.response.redirect(Uri.parse('/'));
    return;
  }

  final view = product_html();
  view.render(product, request);
}

Future<void> _handleProducts(HttpRequest request) async {
  final catalog = CatalogService();
  final products = await catalog.findProducts();
  final view = products_html();
  view.render(products, request);
}
