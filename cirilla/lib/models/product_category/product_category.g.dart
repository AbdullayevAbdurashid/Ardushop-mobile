// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) => ProductCategory(
      id: json['id'] as int?,
      name: unescape(json['name']),
      parent: json['parent'] as int?,
      categories: ProductCategory.toList(json['categories'] as List?),
      description: json['description'] as String?,
      count: json['count'] as int?,
      image: json['image'] as Map<String, dynamic>? ?? {},
    )
      ..display = json['display'] as String?
      ..menuOrder = json['menu_order'] as int?;

Map<String, dynamic> _$ProductCategoryToJson(ProductCategory instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parent': instance.parent,
      'categories': instance.categories,
      'description': instance.description,
      'display': instance.display,
      'image': instance.image,
      'menu_order': instance.menuOrder,
      'count': instance.count,
    };
