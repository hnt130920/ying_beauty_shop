import 'package:json_annotation/json_annotation.dart';

part 'change_info.g.dart';

@JsonSerializable()
class ChangeInfo {
  String name;
  String email;
  String gender;
  ChangeInfo({
    required this.name,
    required this.email,
    required this.gender,
  });

  factory ChangeInfo.fromJson(Map<String, dynamic> json) =>
      _$ChangeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeInfoToJson(this);
}
