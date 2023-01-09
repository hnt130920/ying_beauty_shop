// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['Or_ID'] as int? ?? 0,
      memId: json['Mem_ID'] as int,
      reId: json['Re_ID'] as int,
      date: json['date'] as String? ?? '',
      details: (json['details'] as List<dynamic>?)
          ?.map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'Or_ID': instance.id,
      'Mem_ID': instance.memId,
      'Re_ID': instance.reId,
      'date': instance.date,
      'details': instance.details,
    };
