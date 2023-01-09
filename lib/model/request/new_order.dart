import 'package:json_annotation/json_annotation.dart';
import 'package:ying_beauty/model/order_detail.dart';

part 'new_order.g.dart';

@JsonSerializable()
class NewOrder {
  @JsonKey(name: 'Re_ID')
  int id;
  List<OrderDetail> details;
  NewOrder({
    required this.id,
    required this.details,
  });

  factory NewOrder.fromJson(Map<String, dynamic> json) =>
      _$NewOrderFromJson(json);

  Map<String, dynamic> toJson() => _$NewOrderToJson(this);
}
