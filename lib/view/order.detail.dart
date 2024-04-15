import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rye_coffee/components/order/detail/header.dart';
import 'package:rye_coffee/components/order/detail/header.shimmer.dart';
import 'package:rye_coffee/components/order/detail/list.dart';
import 'package:rye_coffee/components/order/detail/summary.dart';
import 'package:rye_coffee/components/top.navbar.dart';
import 'package:rye_coffee/dummy/data.dart';
import 'package:rye_coffee/model/order.model.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('id');
  bool isLoading = true;
  Order order = Order(
    id: 1,
    date: '-',
    image: '-',
    orderNumber: '-',
    price: 0,
    point: 0,
    status: 1,
    carts: [],
  );
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int id = ModalRoute.of(context)!.settings.arguments as int;
      // log("Argument Value " + id.toString());
      _initPage(id);
    });
    super.initState();
  }

  void _initPage(int id) async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
      order = dummyOrder;
    });
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isLoading
                        ? const OrderDetailHeaderShimmer()
                        : OrderDetailHeader(
                            orderNumber: order.orderNumber,
                            date: order.date,
                            status: order.status,
                          ),
                    const Divider(),
                    const Text(
                      "Detail Pesanan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double height = constraints.maxHeight;
                          return SizedBox(
                            height: height,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: OrderCartListWrapper(
                                carts: order.carts,
                                onLoading: isLoading,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            OrderDetailSummary(
              onLoading: isLoading,
              totalPrice: order.price,
              totalPoint: order.point,
            )
          ],
        ),
      ),
    );
  }
}
