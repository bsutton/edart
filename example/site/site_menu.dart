import 'site_links.dart';

class Menu {
  static final Menu main = Menu([
    MenuItem('Home', '/'),
    MenuItem('Products', SiteLinks.productsIndex),
  ]);

  List<MenuItem> items = [];

  Menu(this.items);

  MenuItem findActive(String url) {
    for (final item in items) {
      if (item.url == url) {
        return item;
      }
    }

    return null;
  }
}

class MenuItem {
  final name;

  MenuItem(this.name, this.url);

  final String url;
}
