import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/card.product.dart';

class ProductListContent extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String type;
  final Function(int id, String name, int price, String image, String type)
      onCartTap;
  final Function(int id) onInfoTap;
  final AsyncCallback onRefresh;
  final Function(int id, String name, int price, String image, String type)
      onTap;

  const ProductListContent({
    Key? key,
    required this.data,
    required this.type,
    required this.onCartTap,
    required this.onInfoTap,
    required this.onRefresh,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: data.isEmpty
            ? SizedBox(
                height: double.infinity,
                width: double.infinity,
                // color: Colors.blue,
                child: Center(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/no-data.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Text(
                            'no data available',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
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
                    onTap: onTap,
                  );
                }).toList(),
              ),
      ),
    );
  }
}
