import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class CardProduct extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final int id;
  final String type;
  final Function(int id, String name, int price, String image, String type)
      onCartTap;
  final Function(int id) onInfoTap;
  // final Function(int id) onCardTap;

  const CardProduct({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.id,
    required this.onCartTap,
    required this.onInfoTap,
    required this.type,
    // required this.onCardTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('id');
    return GestureDetector(
      onTap: () {
        // onCardTap(id);
      },
      child: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 3),
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Text(
                      'Rp${numberFormat.format(price)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            onCartTap(id, name, price, image, type);
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.brown,
                              ),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.shopping_bag,
                                color: Colors.brown,
                                size: 12,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            onInfoTap(id);
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.brown,
                              ),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.info,
                                color: Colors.brown,
                                size: 12,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
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
