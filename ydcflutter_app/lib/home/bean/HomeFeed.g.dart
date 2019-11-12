// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeFeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeFeed _$HomeFeedFromJson(Map<String, dynamic> json) {
  return HomeFeed(
    json['data'] == null
        ? null
        : HomeBean.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HomeFeedToJson(HomeFeed instance) => <String, dynamic>{
      'data': instance.data,
    };

HomeBean _$HomeBeanFromJson(Map<String, dynamic> json) {
  return HomeBean(
    (json['banner'] as List)
        ?.map((e) =>
            e == null ? null : BannerBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['menu'] as List)
        ?.map((e) =>
            e == null ? null : MenuBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['goods'] as List)
        ?.map((e) =>
            e == null ? null : GoodsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomeBeanToJson(HomeBean instance) => <String, dynamic>{
      'banner': instance.banner,
      'menu': instance.menu,
      'goods': instance.goods,
    };

BannerBean _$BannerBeanFromJson(Map<String, dynamic> json) {
  return BannerBean(
    json['id'] as String,
    json['bid'] as String,
    json['title'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$BannerBeanToJson(BannerBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bid': instance.bid,
      'title': instance.title,
      'url': instance.url,
    };

MenuBean _$MenuBeanFromJson(Map<String, dynamic> json) {
  return MenuBean(
    json['id'] as String,
    json['imageUrl'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$MenuBeanToJson(MenuBean instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
    };

GoodsBean _$GoodsBeanFromJson(Map<String, dynamic> json) {
  return GoodsBean(
    json['id'] as String,
    json['imageUrl'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$GoodsBeanToJson(GoodsBean instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
    };
