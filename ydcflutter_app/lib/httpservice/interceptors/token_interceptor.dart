import 'package:dio/dio.dart';
import 'package:ydcflutter_app/datarepository/ydc_sharedpreferences.dart';
import 'package:ydcflutter_app/config/SharePreferenceKey.dart';

/**
 * Token拦截器
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class TokenInterceptors extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    //授权码
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    options.headers["Authorization"] = _token;
    return options;
  }

  @override
  onResponse(Response response) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson["token"] != null) {
        _token = 'token ' + responseJson["token"];
        await SharedPreferencesHelper.save(SharePreferenceKey.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  ///清除授权
  clearAuthorization() {
    this._token = null;
    SharedPreferencesHelper.remove(SharePreferenceKey.TOKEN_KEY);
  }

  ///获取授权token
  getAuthorization() async {
    String token = await SharedPreferencesHelper.get(SharePreferenceKey.TOKEN_KEY);
    if (token == null) {
      String basic = await SharedPreferencesHelper.get(SharePreferenceKey.USER_BASIC_CODE);
      if (basic == null) {
        //提示输入账号密码
      } else {
        //通过 basic 去获取token，获取到设置，返回token
        return "Basic $basic";
      }
    } else {
      this._token = token;
      return token;
    }
  }
}
