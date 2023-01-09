import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ying_beauty/model/order.dart';
import 'package:ying_beauty/model/product.dart';
import 'package:ying_beauty/model/product_detail.dart';
import 'package:ying_beauty/model/receiver_info.dart';
import 'package:ying_beauty/ui/home/product_view_model.dart';
import 'package:ying_beauty/ui/receiver/receiver_view_model.dart';
// import 'package:ying_beauty/utils/app_variables.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;
  OrderDetailScreen({required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List<ProductDetailt> products = ProductDetailViewModel().products;
  ProductDetailt showProduct(int id) {
    var product = products.firstWhere((x) => x.id == id);
    return product;
  }

  List<ReceiverInfo> receivers = ReceiverViewModel().receivers;
  ReceiverInfo showReceiver(int id) {
    var receiver = receivers.firstWhere((x) => x.id == id);
    return receiver;
  }

  double calculateCost() {
    double totalCost = 0.0;
    for (int i = 0; i < widget.order.details!.length; i++) {
      totalCost += widget.order.details![i].orDePrice *
          widget.order.details![i].orDeQuantity;
    }
    return totalCost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Text(
              'Thông tin đơn hàng',
              style: TextStyle(
                  fontSize: 28,
                  color: Color.fromARGB(255, 107, 148, 72),
                  letterSpacing: 4,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 107, 148, 72),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Địa chỉ nhận hàng',
                      style: TextStyle(
                          fontSize: 18,
                          // fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 107, 148, 72)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Ngày đặt hàng: ${widget.order.date}'),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'Người nhận hàng: ${showReceiver(widget.order.reId).name}'),
                const SizedBox(
                  height: 10,
                ),
                Text('Số điện thoại: ${showReceiver(widget.order.reId).phone}'),
                const SizedBox(
                  height: 10,
                ),
                Text('Giao tại: ${showReceiver(widget.order.reId).address}'),
              ],
            ),
          ),
          Expanded(child: _listOrderItem(context)),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(
                  child: Text(
                    'TỔNG TIỀN',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Expanded(
                    child: Text(
                  NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                      .format(
                    (calculateCost()),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 107, 148, 72)),
                )),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget _listOrderItem(BuildContext context) {
    return ListView.builder(
      itemCount: widget.order.details!.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          width: double.infinity,
          child: Row(
            children: [
              Image.network(
                showProduct(widget.order.details![index].proId).proAvatar,
                width: 100,
                height: 100,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                        showProduct(widget.order.details![index].proId).proName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(widget.order.details![index].orDePrice),
                          ),
                        ),
                        Expanded(
                            child: Text(
                          'X${widget.order.details![index].orDeQuantity}',
                        ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
