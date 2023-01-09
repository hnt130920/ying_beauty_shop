import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:ying_beauty/model/product_detail.dart';
import 'package:ying_beauty/model/sqlite/cart.dart';
import 'package:ying_beauty/provider/cart_provider.dart';
import 'package:ying_beauty/ui/cart/cartdb_view_model.dart';

class ItemDetailScreen extends StatefulWidget {
  final ProductDetailt product;
  ItemDetailScreen({required this.product});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  CartDBViewModel cartVM = CartDBViewModel();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
        backgroundColor: const Color.fromARGB(246, 252, 250, 250),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          items: [
                            widget.product.proAvatar,
                            widget.product.proImg1,
                            widget.product.proImg2
                          ]
                              .map(
                                (item) => Container(
                                  // padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    item,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              )
                              .toList(),
                          carouselController: _controller,
                          options: CarouselOptions(
                              height: 300,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 2.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.product.proAvatar,
                            widget.product.proImg1,
                            widget.product.proImg2
                          ].asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                        .withOpacity(
                                            _current == entry.key ? 0.9 : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),
                        Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(widget.product.proPrice),
                            style: const TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 107, 148, 72),
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.product.proName,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    // elevation: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Mô tả sản phẩm',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 107, 148, 72),
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(widget.product.proDescription)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Thành phần chi tiết',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 107, 148, 72),
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(widget.product.proIngredient)
                      ],
                    ),
                  ),
                ],
              ),
            )),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 107, 148, 72),
                    child: TextButton(
                        onPressed: () {
                          showTopSnackBar(
                            padding: const EdgeInsets.all(4),
                            animationDuration:
                                const Duration(milliseconds: 700),
                            reverseAnimationDuration:
                                const Duration(milliseconds: 500),
                            displayDuration: const Duration(milliseconds: 500),
                            Overlay.of(context),
                            const CustomSnackBar.success(
                              icon: Icon(Icons.add_shopping_cart_sharp,
                                  color: Color(0x15000000), size: 120),
                              backgroundColor:
                                  Color.fromARGB(255, 107, 148, 72),
                              message: 'Sản phẩm đã được thêm vào giỏ hàng',
                            ),
                          );

                          final data = Cart(
                              name: widget.product.proName,
                              price: widget.product.proPrice,
                              proId: widget.product.id,
                              quantity: 1,
                              img: widget.product.proAvatar);
                          cartVM.save(data);
                          cart.addCounter();
                          cart.addTotalPrice(widget.product.proPrice);
                        },
                        child: const Text(
                          'Mua Hàng',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
