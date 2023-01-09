import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ying_beauty/model/sqlite/cart.dart';

import 'package:ying_beauty/ui/cart/cartdb_view_model.dart';

class OrderItem extends StatefulWidget {
  final Cart cart;

  OrderItem({required this.cart});
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  CartDBViewModel cartVM = CartDBViewModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Row(
        children: [
          Image.network(
            widget.cart.img,
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
                Text(widget.cart.name,
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
                            .format(widget.cart.price),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      'X${widget.cart.quantity.toString()}',
                    ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
