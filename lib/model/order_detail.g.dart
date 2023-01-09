// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) => OrderDetail(
      id: json['OrDe_ID'] as int? ?? 0,
      orDePrice: (json['orDePrice'] as num).toDouble(),
      orDeQuantity: json['orDeQuantity'] as int,
      proId: json['ProDe_ID'] as int,
      orDeSale: (json['orDeSale'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'OrDe_ID': instance.id,
      'orDeQuantity': instance.orDeQuantity,
      'orDePrice': instance.orDePrice,
      'ProDe_ID': instance.proId,
      'orDeSale': instance.orDeSale,
    };
