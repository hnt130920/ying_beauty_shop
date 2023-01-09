import 'package:json_annotation/json_annotation.dart';
import 'package:ying_beauty/model/cart_detail.dart';
import 'package:ying_beauty/model/order_detail.dart';

part 'update_cart.g.dart';

@JsonSerializable()
class UpdateCart {
  List<CartDetail> details;
  UpdateCart({
    required this.details,
  });

  factory UpdateCart.fromJson(Map<String, dynamic> json) =>
      _$UpdateCartFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCartToJson(this);
}
