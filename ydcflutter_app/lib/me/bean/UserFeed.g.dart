// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserFeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFeed _$UserFeedFromJson(Map<String, dynamic> json) {
  return UserFeed(
    json['data'] == null
        ? null
        : UserInfoBean.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserFeedToJson(UserFeed instance) => <String, dynamic>{
      'data': instance.data,
    };

UserInfoBean _$UserInfoBeanFromJson(Map<String, dynamic> json) {
  return UserInfoBean(
    json['uid'],
    json['username'] as String,
    json['password'] as String,
    json['realname'] as String,
    json['nickname'] as String,
    json['developertype'] as String,
    json['email'] as String,
    json['status'],
    json['createdate'],
    json['createdatestr'] as String,
    json['verifyreason'] as String,
  );
}

Map<String, dynamic> _$UserInfoBeanToJson(UserInfoBean instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'password': instance.password,
      'realname': instance.realname,
      'nickname': instance.nickname,
      'developertype': instance.developertype,
      'email': instance.email,
      'status': instance.status,
      'createdate': instance.createdate,
      'createdatestr': instance.createdatestr,
      'verifyreason': instance.verifyreason,
    };
