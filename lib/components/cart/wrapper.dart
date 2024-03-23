import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/cart/cart.card.shimmer.dart';
import 'package:rye_coffee/components/cart/cart.dart';
import 'package:rye_coffee/model/cart.model.dart';

class CartListWrapper extends StatelessWidget {
  final bool onLoading;
  final List<Cart> carts;
  final AsyncCallback onItemRemove;
  final VoidCallback onQtyChange;

  const CartListWrapper({
    Key? key,
    required this.onLoading,
    required this.carts,
    required this.onItemRemove,
    required this.onQtyChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: onLoading
          ? const [
              CartCardShimmer(),
              CartCardShimmer(),
              CartCardShimmer(),
              CartCardShimmer(),
              CartCardShimmer(),
            ]
          : carts.map((e) {
              return CardCart(
                item: e,
                onItemRemove: onItemRemove,
                onQtyChange: onQtyChange,
              );
            }).toList(),
    );
  }
}
