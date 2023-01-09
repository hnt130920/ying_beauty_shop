import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/db/cart_dao.dart';
import 'package:ying_beauty/model/sqlite/cart.dart';

class CartDBViewModel extends Model {
  static final CartDBViewModel _instance = CartDBViewModel._internal();
  factory CartDBViewModel() => _instance;
  CartDao _repo = CartDao();
  List<Cart> carts = [];

  CartDBViewModel._internal() {
    updateList();
  }
  void updateList() async {
    carts = await _repo.getCarts();
    notifyListeners();
  }

  void save(Cart cart) async {
    Cart? cartDB = await _repo.get(cart.proId);
    if (cartDB == null) {
      await _repo.insert(cart);
    } else {
      cartDB.quantity += cart.quantity;
      await _repo.update(cartDB);
    }

    updateList();
  }

  void delete(Cart cart) async {
    await _repo.delete(cart.proId);
    updateList();
  }

  void clearCart() async {
    await _repo.deleteAll();
    updateList();
  }
}
