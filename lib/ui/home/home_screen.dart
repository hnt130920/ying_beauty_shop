import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/cart_detail.dart';
import 'package:ying_beauty/model/request/update_cart.dart';
import 'package:ying_beauty/model/sqlite/cart.dart';
import 'package:ying_beauty/provider/cart_provider.dart';
import 'package:ying_beauty/ui/cart/cart_info_view_model.dart';
import 'package:ying_beauty/ui/cart/cart_screen.dart';
import 'package:ying_beauty/ui/cart/cart_view_model.dart';
import 'package:ying_beauty/ui/cart/cartdb_view_model.dart';
import 'package:ying_beauty/ui/components/carousel.dart';
import 'package:ying_beauty/ui/home/item_screen.dart';
import 'package:ying_beauty/ui/home/product_view_model.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final productVM = ProductDetailViewModel();
  final info = CartViewModel();
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
    // final cart = Provider.of<CartProvider>(context);
    return WillPopScope(
      onWillPop: () => _onExitButton(context),
      child: ScopedModel(
          model: productVM,
          child: Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: const Color.fromARGB(255, 107, 148, 72),
                title: const Text(
                  'Ying Beauty',
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
              body: Column(
                children: [
                  const CarouselCustom(),
                  Expanded(child: _gridItems()),
                ],
              ))),
    );
  }

  Widget _gridItems() => ScopedModelDescendant<ProductDetailViewModel>(builder:
          (BuildContext context, Widget? child, ProductDetailViewModel model) {
        return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color.fromARGB(255, 210, 224, 201),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (model.products.isEmpty)
                    ? Column(children: [
                        const Text(
                          'Đang tải sản phẩm',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 107, 148, 72)),
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
                    : Expanded(
                        child: GridView.builder(
                          itemCount: model.products.length,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6),
                          itemBuilder: (context, index) {
                            return ItemScreen(
                              product: model.products[index],
                            );
                          },
                        ),
                      )
              ],
            ));
      });

  final cartVM = CartDetailViewModel();

  Future<void> updateApi() async {
    List<Cart> cartsDB = CartDBViewModel().carts;
    final cartsInfo = CartViewModel();
    if (cartsDB.isNotEmpty) {
      List<CartDetail> cartList = [];
      for (int i = 0; i < cartsDB.length; i++) {
        final data = CartDetail(
            proID: cartsDB[i].proId, caDeQuantity: cartsDB[i].quantity);
        cartList.add(data);
      }
      cartsInfo.save(UpdateCart(details: cartList));
    }
    Navigator.of(context).pop(true);
  }

  Future<bool> _onExitButton(BuildContext context) async {
    bool exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thông báo'),
            content: const Text('Bạn muốn thoát ứng dụng ??'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Không')),
              TextButton(
                  onPressed: () {
                    updateApi();
                  },
                  child: const Text('Đồng ý'))
            ],
          );
        });
    return exitApp;
  }
}
