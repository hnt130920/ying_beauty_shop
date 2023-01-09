// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordInfo _$ChangePasswordInfoFromJson(Map<String, dynamic> json) =>
    ChangePasswordInfo(
      id: json['Mem_ID'] as int,
      username: json['username'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      token: json['api_token'] as String,
      expired: json['api_expired'] as String? ?? '',
      created: json['created_at'] as String? ?? '',
      update: json['updated_at'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      bgImg: json['bgImg'] as String? ?? '',
    );

Map<String, dynamic> _$ChangePasswordInfoToJson(ChangePasswordInfo instance) =>
    <String, dynamic>{
      'Mem_ID': instance.id,
      'username': instance.username,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'bgImg': instance.bgImg,
      'gender': instance.gender,
      'api_token': instance.token,
      'api_expired': instance.expired,
      'updated_at': instance.update,
      'created_at': instance.created,
    };
