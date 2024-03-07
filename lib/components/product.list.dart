import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rye_coffee/components/card.product.dart';
import 'package:rye_coffee/dummy/data.dart';

class ProductList extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String type;
  final Function(int id, String name, int price, String image, String type)
      onCartTap;
  final Function(int id) onInfoTap;
  final AsyncCallback onRefresh;

  const ProductList({
    Key? key,
    required this.onCartTap,
    required this.onInfoTap,
    required this.type,
    required this.onRefresh,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: data.isEmpty
            ? Container(
                height: double.infinity,
                width: double.infinity,
                // color: Colors.blue,
                child: Center(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/no-data.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : GridView.count(
                padding: const EdgeInsets.only(bottom: 60),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
                children: data.map((e) {
                  return CardProduct(
                    image: e['image'].toString(),
                    name: e['name'].toString(),
                    price: e['price'] as int,
                    id: e['id'] as int,
                    type: type,
                    onCartTap: onCartTap,
                    onInfoTap: onInfoTap,
                  );
                }).toList(),
              ),
      ),
    );
  }
}
