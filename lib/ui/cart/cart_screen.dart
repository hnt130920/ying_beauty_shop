import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/provider/cart_provider.dart';
import 'package:ying_beauty/ui/cart/cart_item.dart';
import 'package:ying_beauty/ui/cart/cartdb_view_model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ying_beauty/ui/order/order_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartDBVM = CartDBViewModel();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return ScopedModel(
      model: cartDBVM,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: const Color.fromARGB(255, 107, 148, 72),
            title: const Text(
              'Giỏ hàng',
              style: TextStyle(fontSize: 24),
            ),
            actions: [
              // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: badges.Badge(
                  badgeColor: Colors.grey,
                  position: badges.BadgePosition.topEnd(top: 3, end: 2),
                  badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return Text(
                        value.getCounter().toString(),
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                  animationType: badges.BadgeAnimationType.scale,
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartScreen()));
                      },
                      icon: const Icon(Icons.shopping_cart)),
                ),
              ),
            ],
          ),
          body: Container(
              padding: const EdgeInsets.only(top: 8),
              child: (cartDBVM.carts.isEmpty)
                  ? const Center(
                      child: Text(
                        'Chưa có sản phẩm',
                        style: TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(255, 107, 148, 72)),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(child: _listCarts()),
                        Padding(
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: Consumer<CartProvider>(
                                  builder: (context, value, child) {
                                    return Text(
                                      NumberFormat.simpleCurrency(
                                              locale: 'vi-VN', decimalDigits: 0)
                                          .format(
                                        (value.getTotalPrice()),
                                      ),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 107, 148, 72)),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Color.fromARGB(255, 107, 148, 72),
                                  child: TextButton(
                                      onPressed: (cartDBVM.carts.isEmpty)
                                          ? null
                                          : () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const OrderScreen()));
                                            },
                                      child: const Text(
                                        'Mua Hàng',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))),
    );
  }

  Widget _listCarts() => ScopedModelDescendant<CartDBViewModel>(builder:
          (BuildContext context, Widget? child, CartDBViewModel model) {
        return ListView.builder(
          itemCount: model.carts.length,
          itemBuilder: (context, index) {
            return CartItem(
              cart: model.carts[index],
              onDelete: (cart) => model.delete(cart),
            );
          },
        );
      });
}
