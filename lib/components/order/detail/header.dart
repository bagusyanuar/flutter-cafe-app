import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/order/order.status.dart';

class OrderDetailHeader extends StatelessWidget {
  final String orderNumber;
  final String date;
  final int status;

  const OrderDetailHeader({
    Key? key,
    required this.orderNumber,
    required this.date,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orderNumber,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            Text(
              date,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 150,
          child: OrderStatus(status: status),
        )
      ],
    );
  }
}
