import 'dart:developer';

import 'package:rye_coffee/helper/storage.dart';
import 'package:rye_coffee/model/cart.model.dart';

class CartResponse {
  bool error;
  String message;

  CartResponse({
    required this.error,
    required this.message,
  });
}

Future<CartResponse> checkoutCart() async {
  CartResponse response = CartResponse(
    error: true,
    message: "internal server error",
  );
  try {
    await Future.delayed(const Duration(seconds: 2));
    List<Cart> carts = await getCart();
    List<dynamic> data = carts.map((cart) {
      return {'id': cart.id, 'type': cart.type, 'qty': cart.qty};
    }).toList();
    Map<String, dynamic> clearResult = await clearCarts();
    bool errorClearCart = clearResult['error'] as bool;
    String message = clearResult['message'] as String;
    if (errorClearCart) {
      return CartResponse(
        error: true,
        message: message,
      );
    }
    log(data.toString());
    response = CartResponse(error: false, message: 'successfully save order');
  } catch (e) {
    response = CartResponse(
      error: true,
      message: "internal server error",
    );
    log(e.toString());
  }
  return response;
}
