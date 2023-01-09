import 'package:json_annotation/json_annotation.dart';
import 'package:ying_beauty/model/order_detail.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: 'Or_ID')
  int id;
  @JsonKey(name: 'Mem_ID')
  int memId;
  @JsonKey(name: 'Re_ID')
  int reId;
  String date;
  List<OrderDetail>? details;
  Order(
      {this.id = 0,
      required this.memId,
      required this.reId,
      this.date = '',
      this.details});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
