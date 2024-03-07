import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/button.floating.cart.dart';
import 'package:rye_coffee/components/modal.add.cart.dart';
import 'package:rye_coffee/components/product.list.dart';
import 'package:rye_coffee/components/chip.categories.dart';
import 'package:rye_coffee/components/navbar.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';
import 'package:rye_coffee/dummy/data.dart';
import 'package:rye_coffee/helper/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedChipCategories = 0;
  int cartQty = 0;
  List<Map<String, dynamic>> categoriesList = [];
  List<Map<String, dynamic>> productsList = [];
  bool isCategoriesLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initPage();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const Navbar(),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ChipCategories(
                          onLoading: isCategoriesLoading,
                          data: categoriesList,
                          selectedChip: selectedChipCategories,
                          onChipChange: ((key) {
                            setState(() {
                              selectedChipCategories = key;
                            });
                          }),
                        ),
                        Expanded(
                          child: ProductList(
                            data: productsList,
                            onRefresh: () async {
                              log('on refresh menu');
                            },
                            type: 'menu',
                            onCartTap: (id, name, price, image, type) {
                              _eventAppendCart(
                                  context, id, name, price, image, type);
                            },
                            onInfoTap: (id) {
                              log('info tapped ${id.toString()}');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ButtonFloatingCart(
                qty: cartQty,
                onTapCart: () {
                  Navigator.pushNamed(context, '/cart').then((value) {
                    _initPage();
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _initPage() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isCategoriesLoading = false;
      categoriesList = DummyCategories;
    });
    int countCart = await getCartCount();
    setState(() {
      cartQty = countCart;
    });
  }

  void _eventAppendCart(
    BuildContext rootContext,
    int id,
    String name,
    int price,
    String image,
    String type,
  ) async {
    Map<String, dynamic> eventResult =
        await saveCartToStorage(id, name, price, 1, image, type);
    bool error = eventResult['error'] as bool;
    String message = eventResult['message'] as String;
    if (!error) {
      // ignore: use_build_context_synchronously
      _showModalCart(rootContext, id, name, price, image, type);
      int countCart = await getCartCount();
      setState(() {
        cartQty = countCart;
      });
    }
  }

  void _showModalCart(
    BuildContext rootContext,
    int id,
    String name,
    int price,
    String image,
    String type,
  ) {
    showModalBottomSheet(
      context: rootContext,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      builder: (builder) {
        return ModalAddToCart(
          id: id,
          name: name,
          price: price,
          image: image,
          type: type,
          onGoToCart: () {
            log('go to cart');
            Navigator.of(rootContext).pushNamed('/cart').then((value) {
              _initPage();
            });
          },
        );
      },
    );
  }
}
