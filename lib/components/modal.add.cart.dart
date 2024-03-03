import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rye_coffee/helper/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModalAddToCart extends StatefulWidget {
  final int id;
  final String name;
  final int price;
  final String type;

  const ModalAddToCart({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.type,
  }) : super(key: key);

  @override
  State<ModalAddToCart> createState() => _ModalAddToCartState();
}

class _ModalAddToCartState extends State<ModalAddToCart> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('id');
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    textEditingController.text = '1';
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('test');
      // _initCarts();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 18,
                ),
              ),
              Text(
                'Rp${numberFormat.format(widget.price)}',
                style: const TextStyle(
                    color: Colors.brown,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  String currentQtyString = textEditingController.text;
                  int currentQty = int.parse(currentQtyString);
                  if (currentQty > 1) {
                    int nextQty = currentQty - 1;
                    textEditingController.text = nextQty.toString();
                    _onChangeQty();
                  }
                },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.brown,
                    border: Border.all(width: 1, color: Colors.brown),
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 40,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: TextField(
                  controller: textEditingController,
                  textAlign: TextAlign.center,
                  readOnly: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: const EdgeInsets.all(1)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  String currentQtyString = textEditingController.text;
                  int currentQty = int.parse(currentQtyString);
                  if (currentQty <= 99) {
                    int nextQty = currentQty + 1;
                    textEditingController.text = nextQty.toString();
                    _onChangeQty();
                  }
                },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.brown,
                    border: Border.all(width: 1, color: Colors.brown),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onChangeQty() async {
    Map<String, dynamic> data = {
      'id': widget.id,
      'name': widget.name,
      'price': widget.price,
      'qty': textEditingController.text,
      'type': widget.type,
    };
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? carts = preferences.getString('carts');
    log(carts.toString());
  }

  void _initCarts() async {
    saveCartToStorage(widget.id, widget.name, widget.price, 1, 'menu');
  }
}
