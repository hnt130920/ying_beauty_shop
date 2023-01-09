import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/cart_detail.dart';
import 'package:ying_beauty/model/sqlite/cart.dart';
import 'package:ying_beauty/ui/cart/cartdb_view_model.dart';
import 'package:ying_beauty/utils/app_variables.dart';

class CartDetailViewModel extends Model {
  static final CartDetailViewModel _instance = CartDetailViewModel._internal();
  factory CartDetailViewModel() => _instance;
  CartDetailViewModel._internal() {
    updateList();
  }
  List<CartDetail> carts = [];
  // List<Cart> cartsDB = CartDBViewModel().carts;
  void updateList() async {
    final results = await AppVariable.api.getCarts();
    carts = results.data ?? [];
    notifyListeners();
  }

  Future<void> save(CartDetail cart) async {
    cart.id == 0
        ? await AppVariable.api.addCart(cart)
        : await AppVariable.api.updateCart(cart.id, cart);
    updateList();
  }

  // Future<void> add(CartDetail cart) async {
  //   await AppVariable.api.addCart(cart);
  //   updateList();
  // }

  // Future<void> update(CartDetail cart) async {
  //   await AppVariable.api.updateCart(cart.id, cart);
  //   updateList();
  // }

  void delete(CartDetail cart) async {
    await AppVariable.api.deleteProduct(cart.id);
    updateList();
  }
}
