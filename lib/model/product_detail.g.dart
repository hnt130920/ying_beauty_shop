// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailt _$ProductDetailtFromJson(Map<String, dynamic> json) =>
    ProductDetailt(
      id: json['ProDe_ID'] as int,
      proName: json['proName'] as String,
      proPrice: (json['proPrice'] as num).toDouble(),
      proAvatar: json['proAvatar'] as String,
      proImg1: json['proImg1'] as String,
      proImg2: json['proImg2'] as String,
      proBrand: json['proBrand'] as String,
      proDescription: json['proDescription'] as String,
      proIngredient: json['proIngredient'] as String,
      proVolume: json['proVolume'] as int,
      proUnit: json['proUnit'] as String,
      proID: json['Pro_ID'] as int,
    );

Map<String, dynamic> _$ProductDetailtToJson(ProductDetailt instance) =>
    <String, dynamic>{
      'ProDe_ID': instance.id,
      'proName': instance.proName,
      'proPrice': instance.proPrice,
      'proAvatar': instance.proAvatar,
      'proImg1': instance.proImg1,
      'proImg2': instance.proImg2,
      'proBrand': instance.proBrand,
      'proDescription': instance.proDescription,
      'proIngredient': instance.proIngredient,
      'proVolume': instance.proVolume,
      'proUnit': instance.proUnit,
      'Pro_ID': instance.proID,
    };
