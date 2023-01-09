import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/product_detail.dart';

import 'package:ying_beauty/utils/app_variables.dart';

class ProductDetailViewModel extends Model {
  static final ProductDetailViewModel _instance =
      ProductDetailViewModel._internal();
  factory ProductDetailViewModel() => _instance;
  ProductDetailViewModel._internal() {
    updateList();
  }
  List<ProductDetailt> products = [];
  void updateList() async {
    final results = await AppVariable.api.getProducts();
    products = results.data ?? [];
    notifyListeners();
  }

  void save(ProductDetailt product) async {
    product.id == 0
        ? await AppVariable.api.addProduct(product)
        : await AppVariable.api.updateProduct(product.id, product);
    updateList();
  }

  void delete(ProductDetailt product) async {
    await AppVariable.api.deleteProduct(product.id);
    updateList();
  }
}
