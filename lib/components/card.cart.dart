import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rye_coffee/components/dialog.confirmation.dart';
import 'package:rye_coffee/helper/util.dart';
import 'package:rye_coffee/model/cart.model.dart';

class CardCart extends StatefulWidget {
  // final int id;
  // final String name;
  // final int qty;
  // final int price;
  // final String image;
  // final String type;
  final Cart item;
  final int cartIndex;
  final VoidCallback onChangeQty;
  final VoidCallback onRemoveItem;

  const CardCart({
    Key? key,
    // required this.id,
    // required this.name,
    // required this.qty,
    // required this.price,
    // required this.image,
    // required this.type,
    required this.item,
    required this.onChangeQty,
    required this.cartIndex,
    required this.onRemoveItem,
  }) : super(key: key);

  @override
  State<CardCart> createState() => _CardCartState();
}

class _CardCartState extends State<CardCart> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('id');
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    textEditingController.text = widget.item.qty.toString();
    super.initState();
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
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(4, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(widget.item.image),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'Rp${numberFormat.format(widget.item.price)}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.brown,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          log(widget.cartIndex.toString());
                          String currentQtyString = textEditingController.text;
                          int currentQty = int.parse(currentQtyString);
                          if (currentQty > 1) {
                            int nextQty = currentQty - 1;
                            textEditingController.text = nextQty.toString();
                            _onChangeQty();
                            widget.onChangeQty();
                          } else {
                            _eventRemoveItemCart(context, widget.cartIndex);
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
                            widget.onChangeQty();
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
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onChangeQty() async {
    // int newQty = int.parse(textEditingController.text);
    // Map<String, dynamic> changeResult =
    //     await changeQtyCartStorage(widget.item.id, widget.type, newQty);
    // bool error = changeResult['error'] as bool;
    // String message = changeResult['message'] as String;
    // if (error) {
    //   log(message);
    // }
  }

  void _eventRemoveItemCart(BuildContext rootContext, int cartIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogConfirmation(
          title: 'Confirmation',
          content: 'Are you sure to remove this product?',
          onYesTap: () {
            _removeItemCartHandler(context, cartIndex);
          },
          onNoTap: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _removeItemCartHandler(BuildContext dialogContext, int cartIndex) async {
    Map<String, dynamic> removeResult = await removeCartItem(cartIndex);
    bool error = removeResult['error'] as bool;
    String message = removeResult['message'] as String;
    log(removeResult.toString());
    if (!error) {
      widget.onRemoveItem();
      // ignore: use_build_context_synchronously
      Navigator.pop(dialogContext);
    }
  }
}
