// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiver_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiverInfo _$ReceiverInfoFromJson(Map<String, dynamic> json) => ReceiverInfo(
      id: json['Re_ID'] as int? ?? 0,
      memId: json['Mem_ID'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$ReceiverInfoToJson(ReceiverInfo instance) =>
    <String, dynamic>{
      'Re_ID': instance.id,
      'Mem_ID': instance.memId,
      'address': instance.address,
      'phone': instance.phone,
      'name': instance.name,
    };
