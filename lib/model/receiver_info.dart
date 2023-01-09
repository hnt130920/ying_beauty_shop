import 'package:json_annotation/json_annotation.dart';

part 'receiver_info.g.dart';

@JsonSerializable()
class ReceiverInfo {
  @JsonKey(name: 'Re_ID')
  int id;
  @JsonKey(name: 'Mem_ID')
  int memId;
  String address;
  String phone;
  String name;
  ReceiverInfo(
      {this.id = 0,
      required this.memId,
      required this.name,
      required this.address,
      required this.phone});

  factory ReceiverInfo.fromJson(Map<String, dynamic> json) =>
      _$ReceiverInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiverInfoToJson(this);
}
