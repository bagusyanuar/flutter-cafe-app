import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rye_coffee/components/card.product.dart';
import 'package:rye_coffee/components/product.list.content.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';
import 'package:rye_coffee/dummy/data.dart';

class ProductList extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String type;
  final Function(int id, String name, int price, String image, String type)
      onCartTap;
  final Function(int id) onInfoTap;
  final AsyncCallback onRefresh;
  final bool onLoading;
  final Function(int id, String name, int price, String image, String type)
      onTap;

  const ProductList({
    Key? key,
    required this.onCartTap,
    required this.onInfoTap,
    required this.type,
    required this.onRefresh,
    required this.data,
    required this.onLoading,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onLoading
        ? GridView.count(
            padding: const EdgeInsets.only(bottom: 60),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4,
            children: [1, 2, 3, 4, 5, 6].map((e) {
              return const MyShimmer(height: 0, width: 0, radius: 10);
            }).toList(),
          )
        : ProductListContent(
            data: data,
            type: type,
            onCartTap: onCartTap,
            onInfoTap: onInfoTap,
            onRefresh: onRefresh,
            onTap: onTap,
          );
  }
}
