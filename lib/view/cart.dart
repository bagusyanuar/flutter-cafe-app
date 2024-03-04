import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/top.navbar.dart';
import 'package:rye_coffee/helper/util.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          ],
        ),
      ),
    );
  }

  void _eventClearCart() async {
    Map<String, dynamic> clearResult = await clearCarts();
    bool error = clearResult['error'] as bool;
    String message = clearResult['message'] as String;
    log(message);
    // if (!clearResult['error']) {
    //   log(message);
    // } else {}
  }
}
