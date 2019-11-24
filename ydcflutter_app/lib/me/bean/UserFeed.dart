
import 'package:json_annotation/json_annotation.dart';
part 'UserFeed.g.dart';

@JsonSerializable()
class UserFeed {

  @JsonKey(name: 'data')
  UserInfoBean data;

  UserFeed(this.data);

  factory UserFeed.fromJson(Map<String, dynamic> srcJson) => _$UserFeedFromJson(srcJson);
  Map<String,dynamic> toJson() => _$UserFeedToJson(this);

}


@JsonSerializable()
class UserInfoBean{
  @JsonKey(name: 'uid')
  var uid;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'password')
  String password;

  @JsonKey(name: 'realname')
  String realname;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'developertype')
  String developertype;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'status')
  var status;

  @JsonKey(name: 'createdate')
  var createdate;

  @JsonKey(name: 'createdatestr')
  String createdatestr;

  @JsonKey(name: 'verifyreason')
  String verifyreason;


  UserInfoBean(this.uid,this.username,this.password,this.realname,this.nickname,this.developertype,this.email,this.status,this.createdate,this.createdatestr,this.verifyreason);

  void setUserName(String name) {
    this.username = name;
  }

  String get getUserName => this.username;

  // 命名构造函数
  UserInfoBean.empty();

  factory UserInfoBean.fromJson(Map<String, dynamic> srcJson) => _$UserInfoBeanFromJson(srcJson);

  Map<String,dynamic> toJson() => _$UserInfoBeanToJson(this);
}

