import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/ui/order/order.dart';
import 'package:ying_beauty/ui/order/order_view_model.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory>
    with TickerProviderStateMixin {
  OrderViewModel orderVM = OrderViewModel();
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OrderViewModel orderVM = OrderViewModel();
    return ScopedModel(
        model: orderVM,
        child: Scaffold(
            body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_2.jpg'),
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  'Lịch sử mua hàng',
                  style: TextStyle(
                      fontSize: 28,
                      color: Color.fromARGB(255, 107, 148, 72),
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
              (orderVM.orders.isEmpty)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          const Text(
                            'Đang tải đơn hàng',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 107, 148, 72),
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CircularProgressIndicator(
                            value: controller.value,
                            semanticsLabel: 'Circular progress indicator',
                            color: const Color.fromARGB(255, 107, 148, 72),
                          ),
                        ])
                  : Expanded(child: _listOrders())
            ],
          ),
        )));
  }

  Widget _listOrders() => ScopedModelDescendant<OrderViewModel>(
          builder: (BuildContext context, Widget? child, OrderViewModel model) {
        return ListView.builder(
          itemCount: model.orders.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: OrderListItem(
                order: model.orders[index],
              ),
            );
          },
        );
      });
}
