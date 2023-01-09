import 'package:json_annotation/json_annotation.dart';

part 'sign_up_info.g.dart';

@JsonSerializable()
class SignUpInfo {
  @JsonKey(name: 'Mem_ID')
  int id;
  String username;
  String name;
  String email;
  String gender;
  @JsonKey(name: 'api_token')
  String token;
  @JsonKey(name: 'api_expired')
  String expired;
  @JsonKey(name: 'updated_at')
  String update;
  @JsonKey(name: 'created_at')
  String created;
  SignUpInfo(
      {required this.id,
      required this.username,
      required this.name,
      required this.email,
      required this.gender,
      required this.token,
      this.expired = '',
      this.update = '',
      this.created = ''});

  factory SignUpInfo.fromJson(Map<String, dynamic> json) =>
      _$SignUpInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpInfoToJson(this);
}
