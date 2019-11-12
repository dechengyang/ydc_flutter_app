import 'package:json_annotation/json_annotation.dart';
part 'HomeFeed.g.dart';

@JsonSerializable()
class HomeFeed{

  @JsonKey(name: 'data')
  HomeBean data;

  HomeFeed(this.data);

  factory HomeFeed.fromJson(Map<String, dynamic> srcJson) => _$HomeFeedFromJson(srcJson);
  Map<String,dynamic> toJson() => _$HomeFeedToJson(this);
}


@JsonSerializable()
class HomeBean {
  @JsonKey(name: 'banner')
  List<BannerBean> banner;

  @JsonKey(name: 'menu')
  List<MenuBean> menu;

  @JsonKey(name: 'goods')
  List<GoodsBean> goods;

  HomeBean(this.banner,this.menu,this.goods);

  factory HomeBean.fromJson(Map<String, dynamic> srcJson) => _$HomeBeanFromJson(srcJson);
  Map<String,dynamic> toJson() => _$HomeBeanToJson(this);
}

@JsonSerializable()
class BannerBean{

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'bid')
  String bid;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'url')
  String url;
  BannerBean(this.id,this.bid,this.title,this.url);

  factory BannerBean.fromJson(Map<String, dynamic> srcJson) => _$BannerBeanFromJson(srcJson);
  Map<String,dynamic> toJson() => _$BannerBeanToJson(this);
}


@JsonSerializable()
class MenuBean{

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'imageUrl')
  String imageUrl;

  @JsonKey(name: 'name')
  String name;

  MenuBean(this.id,this.imageUrl,this.name);

  factory MenuBean.fromJson(Map<String, dynamic> srcJson) => _$MenuBeanFromJson(srcJson);

  Map<String,dynamic> toJson() => _$MenuBeanToJson(this);
}



@JsonSerializable()
class GoodsBean{

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'imageUrl')
  String imageUrl;

  @JsonKey(name: 'name')
  String name;

  GoodsBean(this.id,this.imageUrl,this.name);

  factory GoodsBean.fromJson(Map<String, dynamic> srcJson) => _$GoodsBeanFromJson(srcJson);
  Map<String,dynamic> toJson() => _$GoodsBeanToJson(this);
}
