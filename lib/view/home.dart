import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/button.floating.cart.dart';
import 'package:rye_coffee/components/chip/categories.chip.dart';
import 'package:rye_coffee/components/modal.add.cart.dart';
import 'package:rye_coffee/components/modal/product.dart';
import 'package:rye_coffee/components/product.list.dart';
import 'package:rye_coffee/components/chip.categories.dart';
import 'package:rye_coffee/components/navbar.dart';
import 'package:rye_coffee/components/product/product.wrapper.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';
import 'package:rye_coffee/dummy/data.dart';
import 'package:rye_coffee/helper/storage.dart';
import 'package:rye_coffee/helper/util.dart';
import 'package:rye_coffee/model/category.model.dart';
import 'package:rye_coffee/model/product.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> categories = [];
  List<Product> products = [];
  int selectedChipCategories = 0;
  int cartQty = 0;
  List<Map<String, dynamic>> categoriesList = [];
  List<Map<String, dynamic>> productsList = [];
  bool isCategoriesLoading = true;
  bool isProductsLoading = true;

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
                        CategoriesChip(
                          data: categories,
                          selectedChip: selectedChipCategories,
                          onLoading: isCategoriesLoading,
                          onChipChange: (key, id, type) {
                            setState(() {
                              selectedChipCategories = key;
                            });
                          },
                        ),
                        Expanded(
                          child: ProductsWrapper(
                            data: products,
                            onLoading: isProductsLoading,
                            onRefresh: () async {},
                            onCardTap: (product) {
                              // dynamic m = StorageMapper.productToMap(product);
                              // log(m.toString());
                              _showModalCart(context, product.id);
                            },
                          ),
                        )
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
    log('re init');
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isCategoriesLoading = false;
      categories =
          dummyCategoriesDynamic.map((e) => Category.fromJson(e)).toList();
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isProductsLoading = false;
      products = dummyProductsDynamic.map((e) => Product.fromJson(e)).toList();
    });
    int countCart = await getCartCount();
    setState(() {
      cartQty = countCart;
    });
  }

  void onCartChanged(int count) async {
    log('cart changed');
    setState(() {
      cartQty = count;
    });
  }

  void _showModalCart(BuildContext rootContext, int id) {
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
        return ModalProduct(
          id: id,
          onCartChanged: (count) => onCartChanged(count),
        );
      },
    );
  }
}
