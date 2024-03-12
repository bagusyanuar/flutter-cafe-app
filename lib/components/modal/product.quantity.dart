import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';

class ModalProductQuantity extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function(String qtyString) onQtyChange;
  final bool onLoading;

  const ModalProductQuantity({
    Key? key,
    required this.textEditingController,
    required this.onQtyChange,
    required this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        onLoading
            ? const MyShimmer(
                height: 24,
                width: 120,
                radius: 5,
              )
            : const Text(
                'Jumlah',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            onLoading
                ? const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: MyShimmer(
                      height: 25,
                      width: 25,
                      radius: 5,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      String currentQtyString = textEditingController.text;
                      int currentQty = int.parse(currentQtyString);
                      if (currentQty > 0) {
                        int nextQty = currentQty - 1;
                        textEditingController.text = nextQty.toString();
                        onQtyChange(nextQty.toString());
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
            onLoading
                ? const MyShimmer(
                    height: 30,
                    width: 40,
                    radius: 5,
                  )
                : Container(
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
            onLoading
                ? const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: MyShimmer(
                      height: 25,
                      width: 25,
                      radius: 5,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      String currentQtyString = textEditingController.text;
                      int currentQty = int.parse(currentQtyString);
                      if (currentQty <= 99) {
                        int nextQty = currentQty + 1;
                        textEditingController.text = nextQty.toString();
                        onQtyChange(nextQty.toString());
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
    );
  }
}
