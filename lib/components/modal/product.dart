import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/modal/product.description.dart';
import 'package:rye_coffee/components/modal/product.info.dart';
import 'package:rye_coffee/components/modal/product.quantity.dart';
import 'package:rye_coffee/dummy/data.dart';

class ModalProduct extends StatefulWidget {
  final int id;

  const ModalProduct({Key? key, required this.id}) : super(key: key);

  @override
  State<ModalProduct> createState() => _ModalProductState();
}

class _ModalProductState extends State<ModalProduct> {
  TextEditingController textEditingController = TextEditingController();
  String name = '';
  int price = 0;
  String description = '';
  List<dynamic> packages = [];

  @override
  void initState() {
    // TODO: implement initState
    textEditingController.text = '0';
    super.initState();
    _initPage();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.2,
      maxChildSize: 0.75,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: ModalProductInfo(name: name, price: price),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(),
            ),
            Flexible(
              child: ModalProductDescription(
                  description: description,
                  packages: packages,
                  scrollController: scrollController),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ModalProductQuantity(
                textEditingController: textEditingController,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
              child: GestureDetector(
                onTap: () {
                  // widget.onGoToCart();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Go To Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
    // return Container(
    //   height: MediaQuery.of(context).size.height * 0.7,
    //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       ModalProductInfo(name: name, price: price),
    //       const Divider(),
    //       Expanded(
    //         child: ModalProductDescription(
    //           description: description,
    //           packages: packages,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  void _initPage() async {
    setState(() {
      name = 'Esspresso';
      price = 15000;
      description = 'lorem ipsum color de sit amor';
      packages = DummyPackages;
    });
  }
}
