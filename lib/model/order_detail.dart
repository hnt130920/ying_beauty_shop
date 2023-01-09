import 'package:json_annotation/json_annotation.dart';

part 'order_detail.g.dart';

// @JsonSerializable(explicitToJson: true)
@JsonSerializable()
class OrderDetail {
  @JsonKey(name: 'OrDe_ID')
  int id;
  int orDeQuantity;
  double orDePrice;
  @JsonKey(name: 'ProDe_ID')
  int proId;
  double orDeSale;
  OrderDetail({
    this.id = 0,
    required this.orDePrice,
    required this.orDeQuantity,
    required this.proId,
    this.orDeSale = 0,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}
