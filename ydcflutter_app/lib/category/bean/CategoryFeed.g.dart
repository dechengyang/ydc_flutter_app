// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryFeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryFeed _$CategoryFeedFromJson(Map<String, dynamic> json) {
  return CategoryFeed(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CategoryBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoryFeedToJson(CategoryFeed instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CategoryBean _$CategoryBeanFromJson(Map<String, dynamic> json) {
  return CategoryBean(
    json['id'] as String,
    json['name'] as String,
    (json['item'] as List)
        ?.map((e) => e == null
            ? null
            : CategoryChildBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['pic'] as String,
  );
}

Map<String, dynamic> _$CategoryBeanToJson(CategoryBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pic': instance.pic,
      'item': instance.item,
    };

CategoryChildBean _$CategoryChildBeanFromJson(Map<String, dynamic> json) {
  return CategoryChildBean(
    json['id'] as String,
    json['name'] as String,
    json['pic'] as String,
    json['parentid'] as String,
  );
}

Map<String, dynamic> _$CategoryChildBeanToJson(CategoryChildBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pic': instance.pic,
      'parentid': instance.parentid,
    };
