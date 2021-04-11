import '../models/product.dart';

class CatalogService {
  static final List<Product> _products = [
    Product(1, 'Cool product', 100),
    Product(2, 'Very cool product', 200),
    Product(3, 'Super cool product', 300),
  ];

  Future<List<Product>> findProducts() async {
    return _products.toList();
  }

  Future<Product?> getProduct(int id) async {
    return _products
        .cast<Product?>()
        .firstWhere((e) => e!.id == id, orElse: () => null);
  }
}
