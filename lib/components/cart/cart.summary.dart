import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';

class CardSummary extends StatelessWidget {
  final bool onLoading;
  final bool onLoadingCheckout;
  final int totalPrice;
  final int totalPoint;
  final VoidCallback onCheckout;

  const CardSummary({
    Key? key,
    required this.onLoading,
    required this.totalPrice,
    required this.totalPoint,
    required this.onCheckout,
    required this.onLoadingCheckout,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              onLoading
                  ? const MyShimmer(height: 18, width: 100, radius: 5)
                  : const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  onLoading
                      ? const MyShimmer(
                          height: 16,
                          width: 80,
                          radius: 5,
                          margin: EdgeInsets.only(bottom: 5),
                        )
                      : Text(
                          'Rp${numberFormat.format(totalPrice)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      onLoading
                          ? const MyShimmer(
                              height: 14,
                              width: 14,
                              radius: 5,
                              margin: EdgeInsets.only(right: 3),
                            )
                          : Container(
                              margin: const EdgeInsets.only(right: 3),
                              child: const Icon(
                                Icons.monetization_on,
                                color: Colors.orange,
                                size: 14,
                              ),
                            ),
                      onLoading
                          ? const MyShimmer(height: 14, width: 60, radius: 5)
                          : Text(
                              numberFormat.format(totalPoint),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          onLoading
              ? const MyShimmer(
                  height: 50,
                  width: double.infinity,
                  radius: 10,
                  margin: EdgeInsets.only(top: 10),
                )
              : GestureDetector(
                  onTap: () {
                    if (!onLoadingCheckout) {
                      onCheckout();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        onLoadingCheckout
                            ? Container(
                                height: 14,
                                width: 14,
                                margin: const EdgeInsets.only(right: 5),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: Colors.white,
                                ),
                              )
                            : Container(),
                        Text(
                          onLoadingCheckout ? 'Loading...' : 'Checkout',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

// const Center(
//                       child: Text(
//                         'Checkout',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),