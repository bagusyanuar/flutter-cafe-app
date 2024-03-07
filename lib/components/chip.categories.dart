import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';

class ChipCategories extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final Function(int key) onChipChange;
  final int selectedChip;
  final bool onLoading;

  const ChipCategories({
    Key? key,
    required this.data,
    required this.onChipChange,
    required this.selectedChip,
    required this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onLoading
        ? Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 35,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [1, 2, 3, 4, 5, 6].map((e) {
                return Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: const MyShimmer(
                    height: 35,
                    width: 120,
                    radius: 10,
                  ),
                );
              }).toList(),
            ),
          )
        : Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 35,
            child: ListView(
                scrollDirection: Axis.horizontal,
                // runSpacing: 5,
                // spacing: 10,
                children: data.map((e) {
                  int key = data.indexOf(e);
                  bool isSelected = key == selectedChip;
                  return GestureDetector(
                    onTap: () {
                      onChipChange(key);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isSelected ? Colors.brown : Colors.white,
                        border: Border.all(
                          color: Colors.brown,
                        ),
                      ),
                      child: Text(
                        e['name'].toString(),
                        style: TextStyle(
                            color: isSelected ? Colors.white : Colors.brown,
                            fontSize: 12),
                      ),
                    ),
                  );
                }).toList()),
          );
  }
}
