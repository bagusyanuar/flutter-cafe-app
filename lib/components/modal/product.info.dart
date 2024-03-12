import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';

class ModalProductInfo extends StatelessWidget {
  final String name;
  final int price;
  final bool onLoading;

  const ModalProductInfo({
    Key? key,
    required this.name,
    required this.price,
    required this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('id');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        onLoading
            ? const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: MyShimmer(
                  height: 18,
                  width: 150,
                  radius: 5,
                ),
              )
            : Text(
                name,
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 18,
                ),
              ),
        onLoading
            ? const MyShimmer(
                height: 24,
                width: 100,
                radius: 5,
              )
            : Text(
                'Rp${numberFormat.format(price)}',
                style: const TextStyle(
                    color: Colors.brown,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
      ],
    );
  }
}
