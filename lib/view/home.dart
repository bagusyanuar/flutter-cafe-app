import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/modal.add.cart.dart';
import 'package:rye_coffee/components/product.list.dart';
import 'package:rye_coffee/components/chip.categories.dart';
import 'package:rye_coffee/components/navbar.dart';
import 'package:rye_coffee/dummy/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedChipCategories = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Navbar(),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChipCategories(
                      data: DummyCategories,
                      selectedChip: selectedChipCategories,
                      onChipChange: ((key) {
                        setState(() {
                          selectedChipCategories = key;
                        });
                      }),
                    ),
                    Expanded(
                      child: ProductList(
                        onCartTap: (id, name, price) {
                          log('cart tapped ${id.toString()}');
                          _showModalCart(context, id, name, price, 'menu');
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
    );
  }

  void _showModalCart(
    BuildContext rootContext,
    int id,
    String name,
    int price,
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
          type: type,
        );
      },
    );
  }
}
