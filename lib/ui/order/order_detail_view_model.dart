import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/order_detail.dart';

import 'package:ying_beauty/utils/app_variables.dart';

class OrderDetailViewModel extends Model {
  static final OrderDetailViewModel _instance =
      OrderDetailViewModel._internal();
  factory OrderDetailViewModel() => _instance;
  OrderDetailViewModel._internal() {
    updateList();
  }
  List<OrderDetail> ordersDetail = [];
  void updateList() async {
    final results = await AppVariable.api.getOrdersDetail();
    ordersDetail = results.data ?? [];
    notifyListeners();
  }

  void save(OrderDetail order) async {
    order.id == 0
        ? await AppVariable.api.addOrderDetail(order)
        : await AppVariable.api.updateOrderDetail(order.id, order);
    updateList();
  }
}
