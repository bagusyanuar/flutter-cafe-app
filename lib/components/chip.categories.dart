import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChipCategories extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final Function(int key) onChipChange;
  final int selectedChip;
  const ChipCategories({
    Key? key,
    required this.data,
    required this.onChipChange,
    required this.selectedChip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: Wrap(
          direction: Axis.horizontal,
          runSpacing: 5,
          spacing: 10,
          children: data.map((e) {
            int key = data.indexOf(e);
            bool isSelected = key == selectedChip;
            return GestureDetector(
              onTap: () {
                onChipChange(key);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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


// [
//           Container(
           
//           ),
//         ],