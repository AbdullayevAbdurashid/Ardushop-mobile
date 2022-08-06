// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailValue _$ProductDetailValueFromJson(Map<String, dynamic> json) => ProductDetailValue(
      type: json['type'] as String?,
      customType: json['customType'] as String? ?? 'text',
      text: json['text'] as Map<String, dynamic>?,
      image: json['image'] as Map<String, dynamic>?,
      action: json['action'] as Map<String, dynamic>?,
      buttonBg: json['buttonBg'] as Map<String, dynamic>?,
      buttonBorderColor: json['buttonBorderColor'] as Map<String, dynamic>?,
      buttonBorderRadius: (json['buttonBorderRadius'] as num?)?.toDouble(),
      buttonBorderWidth: (json['buttonBorderWidth'] as num?)?.toDouble(),
      buttonSize: json['buttonSize'] as Map<String, dynamic>?,
      icon: json['icon'] as Map<String, dynamic>?,
      iconColor: json['iconColor'] as Map<String, dynamic>?,
      iconSize: (json['iconSize'] as num?)?.toDouble(),
      imageSize: (json['imageSize'] as num?)?.toDouble(),
      customFieldName: json['customFieldName'] as String?,
    );

Map<String, dynamic> _$ProductDetailValueToJson(ProductDetailValue instance) => <String, dynamic>{
      'type': instance.type,
      'customType': instance.customType,
      'text': instance.text,
      'icon': instance.icon,
      'buttonBg': instance.buttonBg,
      'buttonBorderColor': instance.buttonBorderColor,
      'buttonBorderWidth': instance.buttonBorderWidth,
      'buttonSize': instance.buttonSize,
      'buttonBorderRadius': instance.buttonBorderRadius,
      'iconColor': instance.iconColor,
      'iconSize': instance.iconSize,
      'image': instance.image,
      'imageSize': instance.imageSize,
      'action': instance.action,
      'customFieldName': instance.customFieldName,
    };
