import 'package:flutter/material.dart';
import 'package:rye_coffee/view/home.dart';
import 'package:rye_coffee/view/login.dart';
import 'package:rye_coffee/view/register.dart';
import 'package:rye_coffee/view/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        // '/dashboard': (context) => Dashboard(),
        // '/order': (context) => OrderView(),
        // '/cart': (context) => CartView(),
        // '/waiting-order': (context) => TransactionView(),
        // '/finish-order': (context) => TransactionFinsihView(),
      },
    );
  }
}
