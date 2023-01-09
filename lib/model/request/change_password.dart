import 'package:json_annotation/json_annotation.dart';
part 'change_password.g.dart';

@JsonSerializable()
class ChangePassword {
  String password;
  @JsonKey(name: 'newpassword')
  String newPass;

  ChangePassword({
    required this.password,
    required this.newPass,
  });

  factory ChangePassword.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordToJson(this);
}
