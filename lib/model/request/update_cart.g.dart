// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCart _$UpdateCartFromJson(Map<String, dynamic> json) => UpdateCart(
      details: (json['details'] as List<dynamic>)
          .map((e) => CartDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateCartToJson(UpdateCart instance) =>
    <String, dynamic>{
      'details': instance.details,
    };
