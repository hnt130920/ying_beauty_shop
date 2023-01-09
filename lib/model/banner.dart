import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

@JsonSerializable()
class Banner {
  @JsonKey(name: 'Ba_ID')
  int id;
  String banName;
  String banPlace;
  String banTime;
  String banImg;
  String banDes;
  Banner(
      {this.id = 0,
      required this.banTime,
      required this.banPlace,
      required this.banName,
      required this.banDes,
      required this.banImg});

  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);

  Map<String, dynamic> toJson() => _$BannerToJson(this);
}
