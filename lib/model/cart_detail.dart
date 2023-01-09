import 'package:json_annotation/json_annotation.dart';
import 'package:ying_beauty/model/cart.dart';
import 'package:ying_beauty/model/product_detail.dart';

part 'cart_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class CartDetail {
  @JsonKey(name: 'CaDe_ID')
  int id;
  // @JsonKey(name: 'Ca_ID')
  // int caID;
  @JsonKey(name: 'ProDe_ID')
  int proID;
  int caDeQuantity;
  double caDeSale;
  // @JsonKey(name: 'product_detail')
  // ProductDetailt? detail;
  // Cart? cart;
  CartDetail({
    this.id = 0,
    // required this.caID,
    required this.proID,
    required this.caDeQuantity,
    this.caDeSale = 0,
    // this.detail,
    // this.cart
  });

  factory CartDetail.fromJson(Map<String, dynamic> json) =>
      _$CartDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CartDetailToJson(this);
}
