import 'package:json_annotation/json_annotation.dart';
part 'ShoppingCartFeed.g.dart';


@JsonSerializable()
class ShoppingCartFeed {

  @JsonKey(name: 'data')
  List<ShoppingCartStoreBean> data;

  ShoppingCartFeed(this.data);

  factory ShoppingCartFeed.fromJson(Map<String, dynamic> srcJson) => _$ShoppingCartFeedFromJson(srcJson);
  Map<String,dynamic> toJson() => _$ShoppingCartFeedToJson(this);

}


@JsonSerializable()
class ShoppingCartStoreBean {

  @JsonKey(name: 'couponShow')
  bool couponShow;

  @JsonKey(name: 'goodsIdStr')
  String goodsIdStr;

  @JsonKey(name: 'item')
  List<GoodsToBuyBean> item;

  @JsonKey(name: 'selected')
  bool selected;

  @JsonKey(name: 'storeId')
  String storeId;

  @JsonKey(name: 'storeName')
  String storeName;

  ShoppingCartStoreBean(this.couponShow,this.goodsIdStr,this.item,this.selected,this.storeId,this.storeName,);

  factory ShoppingCartStoreBean.fromJson(Map<String, dynamic> srcJson) => _$ShoppingCartStoreBeanFromJson(srcJson);
  Map<String,dynamic> toJson() => _$ShoppingCartStoreBeanToJson(this);

}


@JsonSerializable()
class GoodsToBuyBean {

  @JsonKey(name: 'count')
  String count;

  @JsonKey(name: 'dValue')
  String dValue;

  @JsonKey(name: 'fee')
  String fee;

  @JsonKey(name: 'goodsId')
  String goodsId;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'inventory')
  String inventory;

  @JsonKey(name: 'isGoodsNew')
  bool isGoodsNew;

  @JsonKey(name: 'limitDesc')
  String limitDesc;

  @JsonKey(name: 'maxBatch')
  String maxBatch;

  @JsonKey(name: 'memo')
  String memo;

  @JsonKey(name: 'minBatch')
  String minBatch;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'path')
  String path;

  @JsonKey(name: 'price')
  String price;

  @JsonKey(name: 'selected')
  bool selected;

  @JsonKey(name: 'skuCfg')
  String skuCfg;

  @JsonKey(name: 'standardCfg')
  String standardCfg;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'storeType')
  String storeType;

  GoodsToBuyBean(this.count,this.dValue,this.fee,this.goodsId,this.id,this.inventory,this.isGoodsNew,this.limitDesc,this.maxBatch,this.memo,this.minBatch,this.name,this.path,this.price,this.selected,this.skuCfg,this.standardCfg,this.status,this.storeType,);

  factory GoodsToBuyBean.fromJson(Map<String, dynamic> srcJson) => _$GoodsToBuyBeanFromJson(srcJson);
  Map<String,dynamic> toJson() => _$GoodsToBuyBeanToJson(this);

}


