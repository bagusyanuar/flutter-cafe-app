import 'package:rye_coffee/model/cart.model.dart';

class Order {
  int id;
  String date;
  String image;
  String orderNumber;
  int price;
  int point;
  int status;
  List<Cart> carts;

  Order(
      {required this.id,
      required this.date,
      required this.image,
      required this.orderNumber,
      required this.price,
      required this.point,
      required this.status,
      required this.carts});
}
