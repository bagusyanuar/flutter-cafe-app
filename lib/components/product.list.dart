import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rye_coffee/components/card.product.dart';
import 'package:rye_coffee/dummy/data.dart';

class ProductList extends StatelessWidget {
  // final Function(int id)? onProductTap;
  final Function(int id) onCartTap;
  final Function(int id) onInfoTap;

  const ProductList({
    Key? key,
    required this.onCartTap,
    required this.onInfoTap,
    // this.onProductTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 4,
        children: DummyProducts.map((e) {
          NumberFormat numberFormat = NumberFormat.decimalPattern('id');
          return CardProduct(
            image: e['image'].toString(),
            name: e['name'].toString(),
            price: numberFormat.format(e['price'] as int),
            id: e['id'] as int,
            // onCardTap: (id) {
            //   if (onProductTap != null) {
            //     onProductTap!(id);
            //   }
            // },
            onCartTap: onCartTap,
            onInfoTap: onInfoTap,
          );
        }).toList(),
      ),
    );
  }
}
