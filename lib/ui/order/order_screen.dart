import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/order_detail.dart';
import 'package:ying_beauty/model/request/new_order.dart';
import 'package:ying_beauty/model/sqlite/cart.dart';
import 'package:ying_beauty/provider/cart_provider.dart';
import 'package:ying_beauty/ui/cart/cartdb_view_model.dart';
import 'package:ying_beauty/ui/components/bottom_navigation_bar.dart';
import 'package:ying_beauty/ui/order/item_order.dart';
import 'package:ying_beauty/ui/order/order_view_model.dart';
import 'package:ying_beauty/ui/receiver/receiver_screen.dart';
import 'package:ying_beauty/ui/receiver/receiver_view_model.dart';
import 'package:ying_beauty/utils/app_variables.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final cartDBVM = CartDBViewModel();
  final orderVM = OrderViewModel();
  double calculateCost() {
    double totalCost = 0.0;
    for (int i = 0; i < cartDBVM.carts.length; i++) {
      totalCost += cartDBVM.carts[i].price * cartDBVM.carts[i].quantity;
    }
    return totalCost;
  }

  void changData() async {
    final result = await ReceiverViewModel().getReceiver(AppVariable.reId);
    setState(() {
      AppVariable.receiver = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: cartDBVM,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(246, 252, 250, 250),
          appBar: AppBar(
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 107, 148, 72)),
            backgroundColor: Colors.white,
            title: const Text(
              'Thông tin đơn hàng',
              style: TextStyle(
                  color: Color.fromARGB(255, 107, 148, 72),
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            children: [
              InkWell(
                onTap: () async {
                  String refresh = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReceiverScreen()));

                  if (refresh == 'refresh') {
                    changData();
                  }
                },
                child: Container(
                  color: const Color.fromARGB(255, 107, 148, 72),
                  child: const ListTile(
                    leading: Icon(
                      Icons.list_alt,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Địa chỉ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              (AppVariable.reId == 0)
                  ? const Text('')
                  : Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppVariable.receiver!.name,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 107, 148, 72),
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "|",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 107, 148, 72),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                AppVariable.receiver!.phone,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 107, 148, 72),
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                          Text(
                            AppVariable.receiver!.address,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 107, 148, 72),
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              Expanded(child: _listOrderItem()),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Expanded(
                      child: Text(
                        'TỔNG TIỀN',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      NumberFormat.simpleCurrency(
                              locale: 'vi-VN', decimalDigits: 0)
                          .format(
                        (calculateCost()),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 107, 148, 72)),
                    )),
                    Expanded(
                      child: Container(
                        color: const Color.fromARGB(255, 107, 148, 72),
                        child: TextButton(
                            onPressed: () {
                              List<Cart> carts = cartDBVM.carts;
                              List<OrderDetail> orderList = [];
                              for (int i = 0; i < carts.length; i++) {
                                OrderDetail orderDetail = OrderDetail(
                                    orDePrice: carts[i].price,
                                    orDeQuantity: carts[i].quantity,
                                    proId: carts[i].proId);
                                orderList.add(orderDetail);
                              }
                              print(orderList.length);

                              orderVM.save(NewOrder(
                                  id: AppVariable.reId, details: orderList));
                              print(AppVariable.reId);
                              print(1111);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const BottomBar()),
                                  (route) => false);
                              CartProvider().setInitialCounter();
                              cartDBVM.clearCart();
                            },
                            child: const Text(
                              'Thanh toán',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _listOrderItem() => ScopedModelDescendant<CartDBViewModel>(builder:
          (BuildContext context, Widget? child, CartDBViewModel model) {
        return ListView.builder(
          itemCount: model.carts.length,
          itemBuilder: (context, index) {
            return OrderItem(
              cart: model.carts[index],
            );
          },
        );
      });
}
