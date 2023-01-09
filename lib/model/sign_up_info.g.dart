// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpInfo _$SignUpInfoFromJson(Map<String, dynamic> json) => SignUpInfo(
      id: json['Mem_ID'] as int,
      username: json['username'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      token: json['api_token'] as String,
      expired: json['api_expired'] as String? ?? '',
      update: json['updated_at'] as String? ?? '',
      created: json['created_at'] as String? ?? '',
    );

Map<String, dynamic> _$SignUpInfoToJson(SignUpInfo instance) =>
    <String, dynamic>{
      'Mem_ID': instance.id,
      'username': instance.username,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'api_token': instance.token,
      'api_expired': instance.expired,
      'updated_at': instance.update,
      'created_at': instance.created,
    };
