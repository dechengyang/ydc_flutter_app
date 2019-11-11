import 'package:dio/dio.dart';

/**
 * header拦截器
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class HeaderInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    ///超时
    options.connectTimeout = 15000;

    return options;
  }
}
