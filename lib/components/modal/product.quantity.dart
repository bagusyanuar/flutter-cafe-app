import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ModalProductQuantity extends StatelessWidget {
  final TextEditingController textEditingController;
  const ModalProductQuantity({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Jumlah',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
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
                  // _onChangeQty();
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
                  // _onChangeQty();
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
