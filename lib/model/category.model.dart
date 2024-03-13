class Category {
  int id;
  String name;
  String type;

  Category({
    required this.id,
    required this.name,
    required this.type,
  });

  factory Category.fromJson(dynamic e) {
    return Category(
      id: e['id'] as int,
      name: e['name'] as String,
      type: e['type'] as String,
    );
  }
}
