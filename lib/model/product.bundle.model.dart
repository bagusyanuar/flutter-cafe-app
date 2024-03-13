class ProductBundle {
  int id;
  String name;
  String image;
  int qty;

  ProductBundle({
    required this.id,
    required this.name,
    required this.image,
    required this.qty,
  });

  factory ProductBundle.fromJson(dynamic e) {
    return ProductBundle(
      id: e['id'] as int,
      name: e['name'] as String,
      image: e['image'] as String,
      qty: e['qty'] as int,
    );
  }
}
