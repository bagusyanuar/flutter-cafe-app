import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonLogin extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final VoidCallback onClick;
  final bool onLoading;
  final String text;

  const ButtonLogin({
    Key? key,
    this.margin,
    required this.onClick,
    required this.onLoading,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      margin: margin,
      child: GestureDetector(
        onTap: () {
          if (!onLoading) {
            onClick();
          }
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                onLoading
                    ? Container(
                        height: 14,
                        width: 14,
                        margin: const EdgeInsets.only(right: 5),
                        child: const CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Colors.white,
                        ),
                      )
                    : Container(),
                Text(
                  onLoading ? 'Loading...' : text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
