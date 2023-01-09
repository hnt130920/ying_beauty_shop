import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  @JsonKey(name: 'Ca_ID')
  int id;
  @JsonKey(name: 'Mem_ID')
  int memID;
  Cart({
    required this.id,
    required this.memID,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
