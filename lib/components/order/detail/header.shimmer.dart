import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';

class OrderDetailHeaderShimmer extends StatelessWidget {
  const OrderDetailHeaderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            MyShimmer(
              height: 18,
              width: 100,
              radius: 5,
              margin: EdgeInsets.only(bottom: 5),
            ),
            MyShimmer(
              height: 14,
              width: 80,
              radius: 5,
              margin: EdgeInsets.only(bottom: 5),
            ),
          ],
        ),
        const MyShimmer(
          height: 20,
          width: 150,
          radius: 5,
          margin: EdgeInsets.only(bottom: 5),
        )
      ],
    );
  }
}
