import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class ModalProductInfo extends StatelessWidget {
  final String name;
  final int price;

  const ModalProductInfo({
    Key? key,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('id');
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.black45,
            fontSize: 18,
          ),
        ),
        Text(
          'Rp${numberFormat.format(price)}',
          style: const TextStyle(
              color: Colors.brown, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
