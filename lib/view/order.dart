import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/order/wrapper.dart';
import 'package:rye_coffee/components/top.navbar.dart';
import 'package:rye_coffee/controller/order.dart';
import 'package:rye_coffee/dummy/data.dart';
import 'package:rye_coffee/model/order.model.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isLoading = true;
  List<Order> orders = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPage();
  }

  void _initPage() async {
    setState(() {
      isLoading = true;
      orders = [];
    });
    OrderResponse response = await fetchOrderList();
    if (!response.error) {
      setState(() {
        isLoading = false;
        orders = response.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const TopNavbar(
            title: "Pesanan",
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double height = constraints.maxHeight;
                return RefreshIndicator(
                  onRefresh: () async {
                    _initPage();
                  },
                  child: SizedBox(
                    height: height,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: OrderListWrapper(
                          onLoading: isLoading,
                          orders: orders,
                          onOrderTap: (id) {
                            log(id.toString());
                            Navigator.pushNamed(context, "/order/detail",
                                arguments: id);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
