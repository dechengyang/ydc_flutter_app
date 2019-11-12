import 'package:dio/dio.dart';
import 'package:ydcflutter_app/config/Constant.dart';

/**
 * Log 拦截器
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class LogsInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    if (Constant.DEBUG) {
      print("请求url：${options.path}");
      print('请求头: ' + options.headers.toString());
      if (options.data != null) {
        print('请求参数: ' + options.data.toString());
      }
      if (options.queryParameters != null) {
        print('请求参数: ' + options.queryParameters.toString());
      }
    }
    return options;
  }

  @override
  onResponse(Response response) async {
    if (Constant.DEBUG) {
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
    }
    return response; // continue
  }

  @override
  onError(DioError err) async {
    if (Constant.DEBUG) {
      print('请求异常: ' + err.toString());
      print('请求异常信息: ' + err.response?.toString() ?? "");
    }
    return err; // continue;
  }
}
