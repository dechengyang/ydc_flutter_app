import 'package:json_annotation/json_annotation.dart';
part 'CategoryFeed.g.dart';


@JsonSerializable()
class CategoryFeed {

  @JsonKey(name: 'data')
  List<CategoryBean> data;

  CategoryFeed(this.data);

  factory CategoryFeed.fromJson(Map<String, dynamic> srcJson) => _$CategoryFeedFromJson(srcJson);
  Map<String,dynamic> toJson() => _$CategoryFeedToJson(this);

}

@JsonSerializable()
class CategoryBean {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'pic')
  String pic;

  @JsonKey(name: 'item')
  List<CategoryChildBean> item;


  CategoryBean(this.id,this.name,this.item,this.pic);

  factory CategoryBean.fromJson(Map<String, dynamic> srcJson) => _$CategoryBeanFromJson(srcJson);
  Map<String,dynamic> toJson() => _$CategoryBeanToJson(this);

}


@JsonSerializable()
class CategoryChildBean {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'pic')
  String pic;

  @JsonKey(name: 'parentid')
  String parentid;


  CategoryChildBean(this.id,this.name,this.pic,this.parentid);

  factory CategoryChildBean.fromJson(Map<String, dynamic> srcJson) => _$CategoryChildBeanFromJson(srcJson);

  Map<String,dynamic> toJson() => _$CategoryChildBeanToJson(this);

}


