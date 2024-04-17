import 'package:rye_coffee/dummy/data.dart';
import 'package:rye_coffee/model/order.model.dart';

class OrderResponse {
  bool error;
  String message;
  List<Order> data;

  OrderResponse({
    required this.error,
    required this.message,
    required this.data,
  });
}

Future<OrderResponse> fetchOrderList() async {
  OrderResponse response = OrderResponse(
    error: true,
    message: "internal server error",
    data: [],
  );
  try {
    await Future.delayed(const Duration(seconds: 1));
    List<Order> data = dummyOrderList;
    response = OrderResponse(
      error: false,
      message: "success",
      data: data,
    );
  } catch (e) {
    response = OrderResponse(
      error: true,
      message: "internal server error",
      data: [],
    );
  }
  return response;
}
