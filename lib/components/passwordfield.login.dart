import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PasswordFieldLogin extends StatelessWidget {
  final Function(String val) onChange;
  final EdgeInsetsGeometry? margin;

  const PasswordFieldLogin({
    Key? key,
    required this.onChange,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      margin: margin,
      child: TextField(
        onChanged: onChange,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          prefixIcon: const Icon(Icons.lock_outline),
          prefixIconColor: Colors.grey,
          hintText: "password",
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusColor: Colors.black54,
        ),
      ),
    );
  }
}
