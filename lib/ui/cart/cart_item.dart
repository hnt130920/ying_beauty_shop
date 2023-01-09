import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ying_beauty/model/sqlite/cart.dart';
import 'package:ying_beauty/provider/cart_provider.dart';
import 'package:ying_beauty/ui/cart/cartdb_view_model.dart';

class CartItem extends StatefulWidget {
  final Cart cart;

  // final Function(Cart cart) onClick;
  final Function(Cart cart)? onDelete;
  CartItem({required this.cart, required this.onDelete});
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  CartDBViewModel cartVM = CartDBViewModel();
  @override
  Widget build(BuildContext context) {
    final cartPro = Provider.of<CartProvider>(context);
    return Card(
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
                Text(
                  NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                      .format(widget.cart.price),
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: widget.cart.quantity == 1
                            ? null
                            : () {
                                final data = Cart(
                                    name: widget.cart.name,
                                    price: widget.cart.price,
                                    proId: widget.cart.proId,
                                    quantity: -1,
                                    img: widget.cart.img);
                                cartVM.save(data);
                                cartPro.removeCounter();
                                cartPro.removeTotalPrice(widget.cart.price);
                              },
                        child: const Text('-')),
                    Text(widget.cart.quantity.toString()),
                    TextButton(
                        onPressed: () {
                          final data = Cart(
                              name: widget.cart.name,
                              price: widget.cart.price,
                              proId: widget.cart.proId,
                              quantity: 1,
                              img: widget.cart.img);
                          cartVM.save(data);
                          cartPro.addCounter();
                          cartPro.addTotalPrice(widget.cart.price);
                        },
                        child: const Text('+')),
                    Expanded(
                        child: TextButton(
                      onPressed: widget.onDelete == null
                          ? null
                          : () {
                              widget.onDelete!(widget.cart);
                              cartPro.removeCounters(widget.cart.quantity);
                              cartPro.removeTotalPrice(
                                  widget.cart.price * widget.cart.quantity);
                            },
                      child: const Text('Xóa sản phẩm'),
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
