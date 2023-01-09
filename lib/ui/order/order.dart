import 'package:flutter/material.dart';
import 'package:ying_beauty/model/order.dart';
import 'package:ying_beauty/model/receiver_info.dart';
import 'package:ying_beauty/ui/order/order_detail_screen.dart';
import 'package:ying_beauty/ui/order/order_view_model.dart';
import 'package:ying_beauty/ui/receiver/receiver_view_model.dart';
import 'package:ying_beauty/utils/app_variables.dart';

class OrderListItem extends StatefulWidget {
  final Order order;
  OrderListItem({required this.order});

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

List<ReceiverInfo> receivers = ReceiverViewModel().receivers;

ReceiverInfo showReceiver(int id) {
  var receiver = receivers.firstWhere((x) => x.id == id);
  return receiver;
}

class _OrderListItemState extends State<OrderListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailScreen(
                      order: widget.order,
                    )));

        // changData(widget.order);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  showReceiver(widget.order.reId).name,
                  style: const TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 107, 148, 72)),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '(${showReceiver(widget.order.reId).phone})',
                  style: const TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 107, 148, 72)),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text('Ngày đặt hàng: ${widget.order.date}'),
          ],
        ),
      ),
    );
  }
}
