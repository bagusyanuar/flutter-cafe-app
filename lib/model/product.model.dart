import 'package:rye_coffee/model/product.bundle.model.dart';

class Product {
  int id;
  String name;
  String image;
  int price;
  String description;
  String type;
  List<ProductBundle> items;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.type,
    required this.items,
  });

  factory Product.fromJson(dynamic e) {
    List<ProductBundle> bundles = [];
    String type = e['type'] as String;

    if (type == 'package') {
      List<dynamic> tmpBundle = e['items'] as List<dynamic>;
      bundles = tmpBundle.map((e) => ProductBundle.fromJson(e)).toList();
    }
    return Product(
      id: e['id'] as int,
      name: e['name'] as String,
      image: e['image'] as String,
      price: e['price'] as int,
      description: e['description'] as String,
      type: e['type'] as String,
      items: bundles,
    );
  }
}
