import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:rye_coffee/components/button.login.dart';
import 'package:rye_coffee/components/passwordfield.login.dart';
import 'package:rye_coffee/components/textfield.login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
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
                placeholder: 'password',
              ),
              PasswordFieldLogin(
                onChange: (val) {
                  log(val);
                },
                margin: const EdgeInsets.only(bottom: 20),
                placeholder: 'konfirmasi password',
              ),
              ButtonLogin(
                text: 'Register',
                margin: const EdgeInsets.only(bottom: 10),
                onClick: () {
                  log('aabc');
                },
                onLoading: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: const Text(
                      'Sudah Jadi Member?',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).popAndPushNamed('/login');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.brown,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
