import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/cart.dart';
import 'package:ying_beauty/model/product_detail.dart';
import 'package:ying_beauty/model/request/update_cart.dart';

import 'package:ying_beauty/utils/app_variables.dart';

class CartViewModel extends Model {
  static final CartViewModel _instance = CartViewModel._internal();
  factory CartViewModel() => _instance;
  CartViewModel._internal() {
    updateList();
  }
  List carts = [];
  Future<void> updateList() async {
    final results = await AppVariable.api.getCartsInfo();
    carts = results.data ?? [];
    notifyListeners();
  }

  void save(UpdateCart cart) async {
    await AppVariable.api.updateCartInfo(cart);
    updateList();
  }

  void delete(Cart cart) async {
    await AppVariable.api.deleteProduct(cart.id);
    updateList();
  }
}
