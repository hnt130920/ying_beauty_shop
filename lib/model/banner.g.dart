// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banner _$BannerFromJson(Map<String, dynamic> json) => Banner(
      id: json['Ba_ID'] as int? ?? 0,
      banTime: json['banTime'] as String,
      banPlace: json['banPlace'] as String,
      banName: json['banName'] as String,
      banDes: json['banDes'] as String,
      banImg: json['banImg'] as String,
    );

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'Ba_ID': instance.id,
      'banName': instance.banName,
      'banPlace': instance.banPlace,
      'banTime': instance.banTime,
      'banImg': instance.banImg,
      'banDes': instance.banDes,
    };
