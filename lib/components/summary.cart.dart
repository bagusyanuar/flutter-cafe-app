import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class SummaryCart extends StatelessWidget {
  final int totalPrice;
  final int totalPoint;

  const SummaryCart({
    Key? key,
    required this.totalPrice,
    required this.totalPoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('id');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.of(context).size.width,
      // height: 140,
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
              const Expanded(
                child: Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
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
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
