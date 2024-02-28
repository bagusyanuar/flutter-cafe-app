import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/passwordfield.login.dart';
import 'package:rye_coffee/components/textfield.login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 80,
                  width: 100,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/brand.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              TextFieldLogin(
                onChange: (val) {
                  log(val);
                },
                margin: const EdgeInsets.only(bottom: 10),
              ),
              PasswordFieldLogin(
                onChange: (val) {
                  log(val);
                },
                margin: const EdgeInsets.only(bottom: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
