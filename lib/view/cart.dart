import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rye_coffee/components/card.cart.dart';
import 'package:rye_coffee/components/top.navbar.dart';
import 'package:rye_coffee/helper/util.dart';

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
                _eventClearCart();
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
            Container(
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
            )
          ],
        ),
      ),
    );
  }

  void _eventClearCart() async {
    Map<String, dynamic> clearResult = await clearCarts();
    bool error = clearResult['error'] as bool;
    String message = clearResult['message'] as String;
    if (!error) {
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
