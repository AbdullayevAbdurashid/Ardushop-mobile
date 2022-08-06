import 'package:json_annotation/json_annotation.dart';

part 'product_detail_value.g.dart';

@JsonSerializable()
class ProductDetailValue {
  String? type;

  @JsonKey(defaultValue: 'text')
  String? customType;

  Map<String, dynamic>? text;

  Map<String, dynamic>? icon;

  Map<String, dynamic>? buttonBg;

  Map<String, dynamic>? buttonBorderColor;

  double? buttonBorderWidth;

  Map<String, dynamic>? buttonSize;

  double? buttonBorderRadius;

  Map<String, dynamic>? iconColor;

  double? iconSize;

  Map<String, dynamic>? image;

  double? imageSize;

  Map<String, dynamic>? action;

  String? customFieldName;

  ProductDetailValue({
    this.type,
    this.customType,
    this.text,
    this.image,
    this.action,
    this.buttonBg,
    this.buttonBorderColor,
    this.buttonBorderRadius,
    this.buttonBorderWidth,
    this.buttonSize,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.customFieldName,
  });

  factory ProductDetailValue.fromJson(Map<String, dynamic> json) => _$ProductDetailValueFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailValueToJson(this);
}
