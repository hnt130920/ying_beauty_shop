import 'package:json_annotation/json_annotation.dart';

part 'sign_up.g.dart';

@JsonSerializable()
class SignUp {
  String username;
  String password;
  String name;
  String gender;
  String email;
  SignUp(
      {required this.username,
      required this.password,
      required this.email,
      required this.gender,
      required this.name});

  factory SignUp.fromJson(Map<String, dynamic> json) => _$SignUpFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpToJson(this);
}
