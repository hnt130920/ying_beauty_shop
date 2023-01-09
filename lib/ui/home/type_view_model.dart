import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/product.dart';
import 'package:ying_beauty/utils/app_variables.dart';

class ProductViewModel extends Model {
  static final ProductViewModel _instance = ProductViewModel._internal();
  factory ProductViewModel() => _instance;
  ProductViewModel._internal() {
    updateList();
  }
  List<Product> products = [];
  void updateList() async {
    final results = await AppVariable.api.getProductsType();
    products = results.data ?? [];
    notifyListeners();
  }

  void save(Product product) async {
    product.id == 0
        ? await AppVariable.api.addProductType(product)
        : await AppVariable.api.updateProductType(product.id, product);
    updateList();
  }

  void delete(Product product) async {
    await AppVariable.api.deleteProduct(product.id);
    updateList();
  }
}
