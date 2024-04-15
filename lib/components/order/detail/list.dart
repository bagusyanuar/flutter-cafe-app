import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/order/detail/list.item.dart';
import 'package:rye_coffee/components/order/detail/list.item.shimmer.dart';
import 'package:rye_coffee/model/cart.model.dart';

class OrderCartListWrapper extends StatelessWidget {
  final List<Cart> carts;
  final bool onLoading;

  const OrderCartListWrapper({
    Key? key,
    required this.carts,
    required this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: onLoading
          ? const [
              OrderCartListItemShimmer(),
              OrderCartListItemShimmer(),
              OrderCartListItemShimmer(),
              OrderCartListItemShimmer(),
            ]
          : carts.map((e) {
              return OrderCartListItem(item: e);
            }).toList(),
    );
  }
}
