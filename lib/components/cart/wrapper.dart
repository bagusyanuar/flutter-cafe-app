import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/cart/cart.card.shimmer.dart';

class CartListWrapper extends StatelessWidget {
  final bool onLoading;

  const CartListWrapper({
    Key? key,
    required this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        CartCardShimmer(),
        CartCardShimmer(),
        CartCardShimmer(),
        CartCardShimmer(),
        CartCardShimmer(),
      ],
    );
  }
}
