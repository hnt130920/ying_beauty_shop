import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/order.dart';
import 'package:ying_beauty/model/order_detail.dart';
import 'package:ying_beauty/model/request/new_order.dart';
import 'package:ying_beauty/utils/app_variables.dart';

class OrderViewModel extends Model {
  static final OrderViewModel _instance = OrderViewModel._internal();
  factory OrderViewModel() => _instance;
  OrderViewModel._internal() {
    updateList();
  }
  List<Order> orders = [];
  void updateList() async {
    final results = await AppVariable.api.getOrders();
    orders = results.data ?? [];
    notifyListeners();
  }

  Future<Order> getOrder(Order order) async {
    final result = await AppVariable.api.getOrder(order.id);
    order = result.data!;
    return order;
  }

  void save(NewOrder newOrder) async {
    await AppVariable.api.addOrder(newOrder);
    updateList();
  }
}
