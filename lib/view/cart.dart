import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rye_coffee/components/card.cart.dart';
import 'package:rye_coffee/components/dialog.confirmation.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';
import 'package:rye_coffee/components/top.navbar.dart';
import 'package:rye_coffee/helper/util.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('id');
  List<dynamic> dataCart = [];
  int totalPrice = 0, totalPoint = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPage();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopNavbar(
              title: 'Cart',
              actionButton: const SizedBox(
                width: 45,
                height: 45,
                child: Center(
                  child: Icon(
                    Icons.delete_outlined,
                    color: Colors.brown,
                    size: 18,
                  ),
                ),
              ),
              onActionTap: () {
                _eventClearCart(context);
              },
            ),
            Flexible(
              child: RefreshIndicator(
                onRefresh: () async {
                  log('refreshed');
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: dataCart.map((e) {
                        int cartIndex = dataCart.indexOf(e);
                        int id = e['id'] as int;
                        String name = e['name'] as String;
                        int price = e['price'] as int;
                        int qty = e['qty'] as int;
                        String image = e['image'] as String;
                        return CardCart(
                          id: id,
                          name: name,
                          qty: qty,
                          price: price,
                          image: image,
                          type: 'menu',
                          cartIndex: cartIndex,
                          onChangeQty: () {
                            _getSummaryCart();
                          },
                          onRemoveItem: () {
                            _initPage();
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _eventClearCart(BuildContext rootContext) {
    showDialog(
      context: rootContext,
      builder: (BuildContext context) {
        return DialogConfirmation(
          title: 'Confirmation',
          content: 'Are you sure to clear cart?',
          onYesTap: () {
            _clearCartHandler(context);
          },
          onNoTap: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _clearCartHandler(BuildContext dialogContext) async {
    Map<String, dynamic> clearResult = await clearCarts();
    bool error = clearResult['error'] as bool;
    String message = clearResult['message'] as String;
    if (!error) {
      // ignore: use_build_context_synchronously
      Navigator.pop(dialogContext);
      _initPage();
    }
  }

  void _getSummaryCart() async {
    Map<String, int> result = await getSummaryCarts();
    int resultPrice = result['price'] as int;
    int resultPoint = result['point'] as int;
    setState(() {
      totalPrice = resultPrice;
      totalPoint = resultPoint;
    });
  }

  void _initPage() async {
    List<dynamic> cartStorage = await getCartStorage();
    setState(() {
      dataCart = cartStorage;
    });
    _getSummaryCart();
  }
}
