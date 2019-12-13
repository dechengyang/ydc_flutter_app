import 'dart:convert';
import 'package:ydcflutter_app/dao/dao_result.dart';
import 'package:ydcflutter_app/me/bean/UserFeed.dart';
import 'package:ydcflutter_app/datarepository/db/provider/userinfo_db_provider.dart';


class UserDao {
  ///保存用户详细信息
  static setUserInfo(token, user) async {
    UserInfoDbProvider provider = new UserInfoDbProvider();
    await provider.insert(token, json.encode(user.toJson()));
  }

  ///获取用户详细信息
  static getUserInfo(token) async {
    next() async {
      UserInfoDbProvider provider = new UserInfoDbProvider();
      UserInfoBean user = await provider.getUserInfo(token);
      DataResult dataResult = new DataResult(user, true, next: next);
      return dataResult;
    }

    return await next();
  }
}
