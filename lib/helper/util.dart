import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> saveCartToStorage(
  int id,
  String name,
  int price,
  int qty,
  String type,
) async {
  Map<String, dynamic> result = {'error': true, 'message': 'error add to cart'};
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? carts = preferences.getString('carts');
    if (carts == null) {
      List<Map<String, dynamic>> tmpCarts = [];
      Map<String, dynamic> tmpItem = {
        'id': id,
        'name': name,
        'price': price,
        'qty': 1,
        'type': type,
      };
      tmpCarts.add(tmpItem);
      String cartJSON = json.encode(tmpCarts);
      preferences.setString('carts', cartJSON);
      result = {'error': false, 'message': 'success add to cart'};
    } else {
      dynamic cartJSON = json.decode(carts);
      if (cartJSON is List<dynamic>) {
        Map<String, dynamic>? item = cartJSON
            .firstWhere((element) => element['id'] == id, orElse: () => null);
        if (item == null) {
          dynamic newItem = {
            'id': id,
            'name': name,
            'price': price,
            'qty': 1,
            'type': type,
          };
          cartJSON.add(newItem);
          String newCartJSON = json.encode(cartJSON);
          preferences.setString('carts', newCartJSON);
          result = {'error': false, 'message': 'success add to cart'};
        } else {
          log('item is exists in cart');
          result = {'error': true, 'message': 'item exists in cart'};
        }
      }
    }
  } catch (e) {
    result = {'error': true, 'message': e.toString()};
  }
  return result;
}

Future<Map<String, dynamic>> changeQtyCartStorage(
    int id, String type, int qty) async {
  Map<String, dynamic> result = {'error': true, 'message': 'error add to cart'};
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? carts = preferences.getString('carts');
    if (carts != null) {
      dynamic cartJSON = json.decode(carts);
      if (cartJSON is List<dynamic>) {
        Map<String, dynamic>? item = cartJSON.firstWhere(
            (element) => (element['id'] == id && element['type'] == type),
            orElse: () => null);
        if (item != null) {
          int itemIndex = cartJSON.indexOf(item);
          item['qty'] = qty;
          cartJSON[itemIndex] = item;
          result = {'error': false, 'message': 'success change qty'};
          log(cartJSON.toString());
        } else {
          result = {'error': true, 'message': 'item not in carts'};
        }
      } else {
        result = {'error': true, 'message': 'cart is not list type'};
      }
    } else {
      result = {'error': true, 'message': 'cart empty'};
    }
  } catch (e) {
    result = {'error': true, 'message': e.toString()};
  }
  return result;
}

Future<int> getCartCount() async {
  int result = 0;
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? carts = preferences.getString('carts');
    if (carts != null) {
      dynamic cartJSON = json.decode(carts);
      if (cartJSON is List<dynamic>) {
        result = cartJSON.length;
      }
    }
  } catch (e) {
    log('flutter error ${e.toString()}');
  }
  return result;
}

Future<Map<String, dynamic>> clearCarts() async {
  Map<String, dynamic> result = {'error': true, 'message': 'error clear cart'};
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? carts = preferences.getString('carts');
    if (carts != null) {
      dynamic cartJSON = json.decode(carts);
      if (cartJSON is List<dynamic>) {
        cartJSON.clear();
        String newCartJSON = json.encode(cartJSON);
        preferences.setString('carts', newCartJSON);
        result = {'error': false, 'message': 'success clear cart'};
      } else {
        result = {'error': true, 'message': 'error cart not as list type'};
      }
    }
  } catch (e) {
    result = {'error': true, 'message': e.toString()};
  }
  return result;
}
