// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUp _$SignUpFromJson(Map<String, dynamic> json) => SignUp(
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SignUpToJson(SignUp instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'name': instance.name,
      'gender': instance.gender,
      'email': instance.email,
    };
