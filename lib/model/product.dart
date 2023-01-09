import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'Pro_ID')
  int id;
  @JsonKey(name: 'proType')
  String type;
  @JsonKey(name: 'proImg')
  String img;
  Product({
    required this.id,
    required this.type,
    this.img = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
