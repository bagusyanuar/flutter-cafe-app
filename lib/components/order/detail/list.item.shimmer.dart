import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';

class OrderCartListItemShimmer extends StatelessWidget {
  const OrderCartListItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(4, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const MyShimmer(
            height: 80,
            width: 80,
            radius: 10,
            margin: EdgeInsets.only(right: 10),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MyShimmer(
                  height: 16,
                  width: 120,
                  radius: 5,
                  margin: EdgeInsets.only(bottom: 5),
                ),
                const MyShimmer(
                  height: 14,
                  width: 80,
                  radius: 5,
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      MyShimmer(
                        height: 18,
                        width: 100,
                        radius: 5,
                        margin: EdgeInsets.only(bottom: 5),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
