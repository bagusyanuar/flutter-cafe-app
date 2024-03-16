import 'dart:convert';
import 'dart:developer';

import 'package:rye_coffee/model/cart.model.dart';
import 'package:rye_coffee/model/product.bundle.model.dart';
import 'package:rye_coffee/model/product.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageMapper {
  static dynamic productToMap(Product p) {
    return {
      'id': p.id,
      'name': p.name,
      'image': p.image,
      'type': p.type,
      'price': p.price,
      'items': p.items.map((e) => StorageMapper.productBundleToMap(e)).toList()
    };
  }

  static dynamic productBundleToMap(ProductBundle pb) {
    return {
      'id': pb.id,
      'image': pb.image,
      'name': pb.name,
      'qty': pb.qty,
    };
  }

  static dynamic cartToMap(Cart c) {
    return {
      'id': c.id,
      'image': c.image,
      'name': c.name,
      'qty': c.qty,
      'price': c.price,
      'type': c.type,
    };
  }

  static List<Cart> cartFromJSON(List<dynamic> items) {
    List<Cart> carts = [];
    for (var item in items) {
      Cart cart = Cart(
        id: item['id'] as int,
        name: item['name'] as String,
        image: item['image'] as String,
        price: item['price'] as int,
        qty: item['qty'] as int,
        type: item['type'] as String,
      );
      carts.add(cart);
    }
    return carts;
  }
}

Future<Map<String, dynamic>> isStoragedCartChange(
    Product product, int qty) async {
  Map<String, dynamic> result = {
    'value': false,
    'count': 0,
  };
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? carts = preferences.getString('carts');
    Cart cart = Cart(
      id: product.id,
      name: product.name,
      image: product.image,
      price: product.price,
      qty: qty,
      type: product.type,
    );
    if (carts != null) {
      dynamic currentCartJSON = json.decode(carts);
      if (currentCartJSON is List<dynamic>) {
        dynamic item = _findItemOnCart(currentCartJSON, product);
        if (item != null) {
          int itemIndex = currentCartJSON.indexOf(item);
          if (qty > 0) {
            item['qty'] = qty;
            currentCartJSON[itemIndex] = item;
          } else {
            currentCartJSON.removeAt(itemIndex);
          }

          //delete preference if cart empty
          if (currentCartJSON.length > 1) {
            String cartItemsJSON = json.encode(currentCartJSON);
            preferences.setString('carts', cartItemsJSON);
          } else {
            preferences.remove('carts');
          }
          log('update item on cart');
          result = {
            'value': true,
            'count': currentCartJSON.length,
          };
        } else {
          log('add another item on cart');
          _addToCartStorage(preferences, currentCartJSON, cart);
          result = {
            'value': true,
            'count': currentCartJSON.length,
          };
        }
      }
    } else {
      log('add first item on cart');
      _addToCartStorage(preferences, [], cart);
      result = {
        'value': true,
        'count': 1,
      };
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}

Future<Map<String, dynamic>> isProductOnCart(Product product) async {
  Map<String, dynamic> value = {
    'status': false,
    'qty': 0,
  };
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? carts = preferences.getString('carts');
    if (carts != null) {
      dynamic currentCartJSON = json.decode(carts);
      if (currentCartJSON is List<dynamic>) {
        dynamic item = _findItemOnCart(currentCartJSON, product);
        if (item != null) {
          int qty = item['qty'] as int;
          value = {'status': true, 'qty': qty};
        }
      }
    }
  } catch (e) {
    log(e.toString());
  }
  return value;
}

Future<List<Cart>> getCart() async {
  List<Cart> values = [];
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? carts = preferences.getString('carts');
    if (carts != null) {
      dynamic currentCartJSON = json.decode(carts);
      if (currentCartJSON is List<dynamic>) {
        values = StorageMapper.cartFromJSON(currentCartJSON);
      }
    }
  } catch (e) {
    log(e.toString());
  }
  return values;
}

_addToCartStorage(
    SharedPreferences preferences, List<dynamic> currentCarts, Cart cart) {
  dynamic cartItem = StorageMapper.cartToMap(cart);
  currentCarts.add(cartItem);
  String cartItemsJSON = json.encode(currentCarts);
  preferences.setString('carts', cartItemsJSON);
}

dynamic _findItemOnCart(List<dynamic> cart, Product product) {
  return cart.firstWhere(
      (element) =>
          (element['id'] == product.id && element['type'] == product.type),
      orElse: () => null);
}
