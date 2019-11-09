import 'package:json_annotation/json_annotation.dart';




@JsonSerializable()
class ShopCartBean {

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'result')
  List<ShopCartResult> result;

  @JsonKey(name: 'success')
  bool success;

  ShopCartBean(this.code,this.msg,this.result,this.success,);

  //factory ShopCartBean.fromJson(Map<String, dynamic> srcJson) => _$ShopCartBeanFromJson(srcJson);

}


@JsonSerializable()
class ShopCartResult {

  @JsonKey(name: 'couponShow')
  bool couponShow;

  @JsonKey(name: 'goodsIdStr')
  String goodsIdStr;

  @JsonKey(name: 'goodsToBuyDtos')
  List<GoodsToBuyDtos> goodsToBuyDtos;

  @JsonKey(name: 'selected')
  bool selected;

  @JsonKey(name: 'storeId')
  String storeId;

  @JsonKey(name: 'storeName')
  String storeName;

  ShopCartResult(this.couponShow,this.goodsIdStr,this.goodsToBuyDtos,this.selected,this.storeId,this.storeName,);

  //factory ShopCartResult.fromJson(Map<String, dynamic> srcJson) => _$ShopCartResultFromJson(srcJson);

}


@JsonSerializable()
class GoodsToBuyDtos {

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

  GoodsToBuyDtos(this.count,this.dValue,this.fee,this.goodsId,this.id,this.inventory,this.isGoodsNew,this.limitDesc,this.maxBatch,this.memo,this.minBatch,this.name,this.path,this.price,this.selected,this.skuCfg,this.standardCfg,this.status,this.storeType,);

  //factory GoodsToBuyDtos.fromJson(Map<String, dynamic> srcJson) => _$GoodsToBuyDtosFromJson(srcJson);

}


