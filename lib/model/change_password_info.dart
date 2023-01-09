import 'package:json_annotation/json_annotation.dart';

part 'change_password_info.g.dart';

@JsonSerializable()
class ChangePasswordInfo {
  @JsonKey(name: 'Mem_ID')
  int id;
  String username;
  String name;
  String email;
  String avatar;
  String bgImg;
  String gender;
  @JsonKey(name: 'api_token')
  String token;
  @JsonKey(name: 'api_expired')
  String expired;
  @JsonKey(name: 'updated_at')
  String update;
  @JsonKey(name: 'created_at')
  String created;

  ChangePasswordInfo(
      {required this.id,
      required this.username,
      required this.name,
      required this.email,
      required this.gender,
      required this.token,
      this.expired = '',
      this.created = '',
      this.update = '',
      this.avatar = '',
      this.bgImg = ''});

  factory ChangePasswordInfo.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordInfoToJson(this);
}
