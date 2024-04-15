import 'package:rye_coffee/dummy/data.dart';
import 'package:rye_coffee/model/product.model.dart';

class ProductResponse {
  bool error;
  String message;
  List<Product> data;

  ProductResponse({
    required this.error,
    required this.message,
    required this.data,
  });
}

class ProductByIDResponse {
  bool error;
  String message;
  Product? data;

  ProductByIDResponse({
    required this.error,
    required this.message,
    this.data,
  });
}

Future<ProductResponse> fetchProductList(int categoryID) async {
  ProductResponse response = ProductResponse(
    error: true,
    message: "internal server error",
    data: [],
  );
  try {
    await Future.delayed(const Duration(seconds: 1));
    List<Product> data =
        dummyProductsDynamic.map((e) => Product.fromJson(e)).toList();
    response = ProductResponse(
      error: false,
      message: "success",
      data: data,
    );
  } catch (e) {
    response = ProductResponse(
      error: true,
      message: "internal server error",
      data: [],
    );
  }
  return response;
}

Future<ProductByIDResponse> fetchProductByID(int id, String type) async {
  ProductByIDResponse response = ProductByIDResponse(
    error: true,
    message: "internal server error",
  );
  try {
    await Future.delayed(const Duration(seconds: 1));
    dynamic tmpProduct = dummyProductsDynamic.firstWhere(
        (element) => (element['id'] == id && element['type'] == type),
        orElse: () => null);
    if (tmpProduct != null) {
      Product data = Product(
        id: tmpProduct['id'] as int,
        name: tmpProduct['name'] as String,
        image: tmpProduct['image'] as String,
        price: tmpProduct['price'] as int,
        description: tmpProduct['description'] as String,
        type: tmpProduct['type'] as String,
        items: [],
      );
      response = ProductByIDResponse(
        error: false,
        message: "success",
        data: data,
      );
    } else {
      response = ProductByIDResponse(
        error: true,
        message: "product not found",
      );
    }
  } catch (e) {
    response = ProductByIDResponse(
      error: true,
      message: "internal server error",
    );
  }
  return response;
}
