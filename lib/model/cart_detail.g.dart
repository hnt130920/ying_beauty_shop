// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDetail _$CartDetailFromJson(Map<String, dynamic> json) => CartDetail(
      id: json['CaDe_ID'] as int? ?? 0,
      proID: json['ProDe_ID'] as int,
      caDeQuantity: json['caDeQuantity'] as int,
      caDeSale: (json['caDeSale'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$CartDetailToJson(CartDetail instance) =>
    <String, dynamic>{
      'CaDe_ID': instance.id,
      'ProDe_ID': instance.proID,
      'caDeQuantity': instance.caDeQuantity,
      'caDeSale': instance.caDeSale,
    };
