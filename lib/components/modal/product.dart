import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/modal/product.description.dart';
import 'package:rye_coffee/components/modal/product.info.dart';
import 'package:rye_coffee/components/modal/product.quantity.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';
import 'package:rye_coffee/controller/product.dart';
import 'package:rye_coffee/dummy/data.dart';
import 'package:rye_coffee/helper/storage.dart';
import 'package:rye_coffee/helper/util.dart';
import 'package:rye_coffee/model/product.bundle.model.dart';
import 'package:rye_coffee/model/product.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModalProduct extends StatefulWidget {
  final int id;
  final Function(int count) onCartChanged;

  const ModalProduct({
    Key? key,
    required this.id,
    required this.onCartChanged,
  }) : super(key: key);

  @override
  State<ModalProduct> createState() => _ModalProductState();
}

class _ModalProductState extends State<ModalProduct> {
  TextEditingController textEditingController = TextEditingController();
  Product product = Product(
    id: 0,
    name: '',
    image: '',
    price: 0,
    description: '',
    type: 'menu',
    items: [],
  );
  bool onLoading = true;

  @override
  void initState() {
    // TODO: implement initState

    // _initPage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initPage();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.2,
      maxChildSize: 0.75,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: ModalProductInfo(
                name: product.name,
                price: product.price,
                onLoading: onLoading,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(),
            ),
            Flexible(
              child: ModalProductDescription(
                onLoading: onLoading,
                description: product.description,
                packages: product.items,
                scrollController: scrollController,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ModalProductQuantity(
                onLoading: onLoading,
                textEditingController: textEditingController,
                onQtyChange: (qtyString) {
                  textEditingController.text = qtyString;
                  int qty = int.parse(qtyString);
                  _onQtyChange(product, qty);
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
              child: onLoading
                  ? const MyShimmer(
                      height: 50,
                      width: double.infinity,
                      radius: 5,
                    )
                  : GestureDetector(
                      onTap: () {
                        // widget.onGoToCart();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Go To Cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
            )
          ],
        );
      },
    );
  }

  void _initPage() async {
    setState(() {
      onLoading = true;
    });
    try {
      // await Future.delayed(const Duration(seconds: 2));
      // dynamic p = dummyProductsDynamic.firstWhere(
      //     (element) =>
      //         (element['id'] == widget.id && element['type'] == 'menu'),
      //     orElse: () => null);
      ProductByIDResponse productByIDResponse =
          await fetchProductByID(widget.id, 'menu');
      log(productByIDResponse.message);
      if (!productByIDResponse.error) {
        Product? p = productByIDResponse.data;
        if (p != null) {
          Map<String, dynamic> itemOnCart = await isProductOnCart(p);
          if (itemOnCart['status']) {
            int tmpQty = itemOnCart['qty'] as int;
            textEditingController.text = tmpQty.toString();
          } else {
            textEditingController.text = '0';
          }
          setState(() {
            product = p;
            onLoading = false;
          });
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _onQtyChange(Product product, int qty) async {
    Map<String, dynamic> value = await isStoragedCartChange(product, qty);
    if (value['value']) {
      int count = value['count'] as int;
      widget.onCartChanged(count);
    }
  }
}
