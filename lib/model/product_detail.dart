import 'package:json_annotation/json_annotation.dart';

part 'product_detail.g.dart';

@JsonSerializable()
class ProductDetailt {
  @JsonKey(name: 'ProDe_ID')
  int id;
  String proName;
  double proPrice;
  String proAvatar;
  String proImg1;
  String proImg2;
  String proBrand;
  String proDescription;
  String proIngredient;
  int proVolume;
  String proUnit;
  @JsonKey(name: 'Pro_ID')
  int proID;
  // Product? product;
  ProductDetailt({
    required this.id,
    required this.proName,
    required this.proPrice,
    required this.proAvatar,
    required this.proImg1,
    required this.proImg2,
    required this.proBrand,
    required this.proDescription,
    required this.proIngredient,
    required this.proVolume,
    required this.proUnit,
    required this.proID,
  });

  factory ProductDetailt.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailtFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailtToJson(this);
}
