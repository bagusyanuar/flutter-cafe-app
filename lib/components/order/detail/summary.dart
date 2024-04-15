import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';

class OrderDetailSummary extends StatelessWidget {
  final bool onLoading;
  final int totalPrice;
  final int totalPoint;

  const OrderDetailSummary({
    Key? key,
    required this.totalPrice,
    required this.totalPoint,
    required this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('id');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(4, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          onLoading
              ? const MyShimmer(
                  height: 18,
                  width: 120,
                  radius: 5,
                  margin: EdgeInsets.only(bottom: 5),
                )
              : Text(
                  'Rp${numberFormat.format(totalPrice)}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          onLoading
              ? const MyShimmer(
                  height: 14,
                  width: 50,
                  radius: 5,
                  margin: EdgeInsets.only(bottom: 5),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 3),
                      child: const Icon(
                        Icons.monetization_on,
                        color: Colors.orange,
                        size: 14,
                      ),
                    ),
                    Text(
                      numberFormat.format(totalPoint),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
