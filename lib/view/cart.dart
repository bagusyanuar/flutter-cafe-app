import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rye_coffee/components/cart/cart.dart';
import 'package:rye_coffee/components/cart/cart.summary.dart';
import 'package:rye_coffee/components/cart/wrapper.dart';
import 'package:rye_coffee/components/dialog.confirmation.dart';
import 'package:rye_coffee/components/filler/empty.content.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';
import 'package:rye_coffee/components/top.navbar.dart';
import 'package:rye_coffee/controller/cart.dart';
import 'package:rye_coffee/helper/storage.dart';
import 'package:rye_coffee/helper/util.dart';
import 'package:rye_coffee/model/cart.model.dart';
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
  bool isLoading = true;
  bool isLoadingCheckout = false;
  List<Cart> carts = [];

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
    double safePadding = MediaQuery.of(context).padding.top;
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
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double height = constraints.maxHeight;
                  return RefreshIndicator(
                    child: SizedBox(
                      height: height,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: CartListWrapper(
                            onLoading: isLoading,
                            carts: carts,
                            onQtyChange: () {
                              _eventSummaryChange();
                            },
                            onItemRemove: () async {
                              log('reload cart');
                              _initPage();
                            },
                          ),
                        ),
                      ),
                    ),
                    onRefresh: () async {},
                  );
                },
              ),
            ),
            CardSummary(
              onLoading: isLoading,
              totalPoint: totalPoint,
              totalPrice: totalPrice,
              onLoadingCheckout: isLoadingCheckout,
              onCheckout: () {
                _checkout(context);
              },
            )
          ],
        ),
      ),
    );
  }

  void _checkout(BuildContext rootContext) async {
    setState(() {
      isLoadingCheckout = true;
    });
    CartResponse response = await checkoutCart();
    setState(() {
      isLoadingCheckout = false;
    });

    if (!response.error) {
      // ignore: use_build_context_synchronously
      Navigator.popAndPushNamed(rootContext, "/order");
    }
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

  void _eventSummaryChange() async {
    Map<String, int> summary = await getSummaryCart();
    int tPrice = summary["total_price"] as int;
    int tPoint = summary["total_point"] as int;
    setState(() {
      totalPoint = tPoint;
      totalPrice = tPrice;
    });
  }

  void _initPage() async {
    setState(() {
      isLoading = true;
      carts = [];
      totalPoint = 0;
      totalPrice = 0;
    });
    await Future.delayed(const Duration(seconds: 2));
    List<Cart> cartList = await getCart();
    Map<String, int> summary = await getSummaryCart();
    int tPrice = summary["total_price"] as int;
    int tPoint = summary["total_point"] as int;
    setState(() {
      isLoading = false;
      carts = cartList;
      totalPoint = tPoint;
      totalPrice = tPrice;
    });
  }
}
