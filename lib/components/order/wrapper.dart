import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/order/order.card.shimmer.dart';
import 'package:rye_coffee/components/order/order.dart';
import 'package:rye_coffee/model/order.model.dart';

class OrderListWrapper extends StatelessWidget {
  final bool onLoading;
  final List<Order> orders;
  final Function(int id) onOrderTap;

  const OrderListWrapper({
    Key? key,
    required this.onLoading,
    required this.orders,
    required this.onOrderTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: onLoading
          ? const [
              OrderCardShimmer(),
              OrderCardShimmer(),
              OrderCardShimmer(),
              OrderCardShimmer(),
              OrderCardShimmer(),
            ]
          : orders.map((e) {
              return CardOrder(
                item: e,
                onOrderTap: onOrderTap,
              );
            }).toList(),
    );
  }
}
