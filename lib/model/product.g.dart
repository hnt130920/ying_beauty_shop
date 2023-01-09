// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['Pro_ID'] as int,
      type: json['proType'] as String,
      img: json['proImg'] as String? ?? '',
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'Pro_ID': instance.id,
      'proType': instance.type,
      'proImg': instance.img,
    };
