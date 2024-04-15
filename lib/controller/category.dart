import 'package:rye_coffee/dummy/data.dart';
import 'package:rye_coffee/model/category.model.dart';

class CategoryResponse {
  bool error;
  String message;
  List<Category> data;

  CategoryResponse({
    required this.error,
    required this.message,
    required this.data,
  });
}

Future<CategoryResponse> fetchCategoryList() async {
  CategoryResponse response = CategoryResponse(
    error: true,
    message: "internal server error",
    data: [],
  );
  try {
    await Future.delayed(const Duration(seconds: 1));
    List<Category> data =
        dummyCategoriesDynamic.map((e) => Category.fromJson(e)).toList();
    response = CategoryResponse(
      error: false,
      message: "success",
      data: data,
    );
  } catch (e) {
    response = CategoryResponse(
      error: true,
      message: "internal server error",
      data: [],
    );
  }
  return response;
}
