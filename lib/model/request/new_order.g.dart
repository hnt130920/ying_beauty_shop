// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewOrder _$NewOrderFromJson(Map<String, dynamic> json) => NewOrder(
      id: json['Re_ID'] as int,
      details: (json['details'] as List<dynamic>)
          .map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewOrderToJson(NewOrder instance) => <String, dynamic>{
      'Re_ID': instance.id,
      'details': instance.details,
    };
