// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShoppingCartFeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingCartFeed _$ShoppingCartFeedFromJson(Map<String, dynamic> json) {
  return ShoppingCartFeed(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ShoppingCartStoreBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ShoppingCartFeedToJson(ShoppingCartFeed instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ShoppingCartStoreBean _$ShoppingCartStoreBeanFromJson(
    Map<String, dynamic> json) {
  return ShoppingCartStoreBean(
    json['couponShow'] as bool,
    json['goodsIdStr'] as String,
    (json['item'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsToBuyBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['selected'] as bool,
    json['storeId'] as String,
    json['storeName'] as String,
  );
}

Map<String, dynamic> _$ShoppingCartStoreBeanToJson(
        ShoppingCartStoreBean instance) =>
    <String, dynamic>{
      'couponShow': instance.couponShow,
      'goodsIdStr': instance.goodsIdStr,
      'item': instance.item,
      'selected': instance.selected,
      'storeId': instance.storeId,
      'storeName': instance.storeName,
    };

GoodsToBuyBean _$GoodsToBuyBeanFromJson(Map<String, dynamic> json) {
  return GoodsToBuyBean(
    json['count'] as String,
    json['dValue'] as String,
    json['fee'] as String,
    json['goodsId'] as String,
    json['id'] as String,
    json['inventory'] as String,
    json['isGoodsNew'] as bool,
    json['limitDesc'] as String,
    json['maxBatch'] as String,
    json['memo'] as String,
    json['minBatch'] as String,
    json['name'] as String,
    json['path'] as String,
    json['price'] as String,
    json['selected'] as bool,
    json['skuCfg'] as String,
    json['standardCfg'] as String,
    json['status'] as String,
    json['storeType'] as String,
  );
}

Map<String, dynamic> _$GoodsToBuyBeanToJson(GoodsToBuyBean instance) =>
    <String, dynamic>{
      'count': instance.count,
      'dValue': instance.dValue,
      'fee': instance.fee,
      'goodsId': instance.goodsId,
      'id': instance.id,
      'inventory': instance.inventory,
      'isGoodsNew': instance.isGoodsNew,
      'limitDesc': instance.limitDesc,
      'maxBatch': instance.maxBatch,
      'memo': instance.memo,
      'minBatch': instance.minBatch,
      'name': instance.name,
      'path': instance.path,
      'price': instance.price,
      'selected': instance.selected,
      'skuCfg': instance.skuCfg,
      'standardCfg': instance.standardCfg,
      'status': instance.status,
      'storeType': instance.storeType,
    };
