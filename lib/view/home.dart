import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/card.products.dart';
import 'package:rye_coffee/components/chip.categories.dart';
import 'package:rye_coffee/components/navbar.dart';
import 'package:rye_coffee/dummy/data.dart';

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
                        log(key.toString());
                        setState(() {
                          selectedChipCategories = key;
                        });
                      }),
                    ),
                    Expanded(child: CardProducts()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
