import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/button.login.dart';
import 'package:rye_coffee/components/passwordfield.login.dart';
import 'package:rye_coffee/components/textfield.login.dart';
import 'package:rye_coffee/controller/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool onLoading = false;
  String username = "";
  String password = "";

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
                  setState(() {
                    username = val;
                  });
                },
                margin: const EdgeInsets.only(bottom: 10),
              ),
              PasswordFieldLogin(
                onChange: (val) {
                  setState(() {
                    password = val;
                  });
                },
                margin: const EdgeInsets.only(bottom: 20),
                placeholder: 'password',
              ),
              ButtonLogin(
                text: 'Login',
                margin: const EdgeInsets.only(bottom: 10),
                onClick: () {
                  _loginHandler();
                },
                onLoading: onLoading,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: const Text(
                      'Belum Jadi Member?',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).popAndPushNamed('/register');
                    },
                    child: const Text(
                      'Daftar Sekarang',
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

  void _loginHandler() async {
    setState(() {
      onLoading = true;
    });
    LoginRequest request = LoginRequest(username: username, password: password);
    LoginResponse response = await loginController(request);
    setState(() {
      onLoading = false;
    });
    if (!response.error) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).popAndPushNamed('/home');
    } else {
      log(response.message);
    }
  }
}
