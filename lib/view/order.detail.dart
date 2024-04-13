import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/order/detail/header.dart';
import 'package:rye_coffee/components/top.navbar.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int id = ModalRoute.of(context)!.settings.arguments as int;
      log("Argument Value " + id.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopNavbar(
              title: "Detail Pesanan",
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OrderDetailHeader(
                    orderNumber: "RYE-0001",
                    date: "2 Januari 2024",
                    status: 1,
                  ),
                  const Divider(),
                  Expanded(
                      child: Container(
                    height: double.infinity,
                    width: double.infinity,
                  )),
                  Container(
                    height: 60,
                    color: Colors.blue,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
