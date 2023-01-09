// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) => LoginInfo(
      id: json['id'] as int,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      token: json['token'] as String,
      avatar: json['avatar'] as String? ?? '',
      bgImg: json['bgImg'] as String? ?? '',
    );

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
      'email': instance.email,
      'avatar': instance.avatar,
      'bgImg': instance.bgImg,
      'gender': instance.gender,
      'token': instance.token,
    };
