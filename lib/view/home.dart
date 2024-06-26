import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/button.floating.cart.dart';
import 'package:rye_coffee/components/chip/categories.chip.dart';
import 'package:rye_coffee/components/drawer/drawer.dart';
import 'package:rye_coffee/components/modal.add.cart.dart';
import 'package:rye_coffee/components/modal/product.dart';
import 'package:rye_coffee/components/product.list.dart';
import 'package:rye_coffee/components/chip.categories.dart';
import 'package:rye_coffee/components/navbar.dart';
import 'package:rye_coffee/components/product/product.wrapper.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';
import 'package:rye_coffee/controller/category.dart';
import 'package:rye_coffee/controller/product.dart';
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
                            onRefresh: () async {
                              _initPage();
                            },
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
              child: isProductsLoading
                  ? Container()
                  : ButtonFloatingCart(
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          switch (value) {
            case 1:
              Navigator.pushNamed(context, "/order");
              break;
            case 2:
              Navigator.pushNamed(context, "/profil");
              break;
            default:
          }
        },
        fixedColor: Colors.brown,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: "Pesanan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Profil"),
        ],
        currentIndex: 0,
      ),
    );
  }

  void _initPage() async {
    setState(() {
      isCategoriesLoading = true;
      isProductsLoading = true;
    });

    //fetch category list
    CategoryResponse categoryResponse = await fetchCategoryList();
    if (!categoryResponse.error) {
      Category selectedCategory = categoryResponse.data.first;
      setState(() {
        categories = categoryResponse.data;
        isCategoriesLoading = false;
      });

      //fetch product list by selected ctegory
      ProductResponse productResponse =
          await fetchProductList(selectedCategory.id);
      if (!productResponse.error) {
        setState(() {
          products = productResponse.data;
          isProductsLoading = false;
        });
      }
    }
    int countCart = await getCartCount();
    setState(() {
      cartQty = countCart;
    });
  }

  void onCartChanged(int count) async {
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
          onGoToCart: () {
            Navigator.pushNamed(rootContext, "/cart")
                .then((value) => Navigator.pop(context));
          },
        );
      },
    );
  }
}
