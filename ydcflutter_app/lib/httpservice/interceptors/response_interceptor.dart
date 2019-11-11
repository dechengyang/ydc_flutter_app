import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:ydcflutter_app/httpservice/result_data.dart';
import 'package:ydcflutter_app/httpservice/code.dart';

/**
 * 网络请求响应拦截
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class ResponseInterceptors extends InterceptorsWrapper {

  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;
    var value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if ((header != null && header.toString().contains("text"))) {
        value = new ResultData(response.toString(), true, Code.SUCCESS);
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        value = new ResultData(response.toString(), true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + option.path);
      value = new ResultData(response.toString(), false, response.statusCode,
          headers: response.headers);
    }
    return value;
  }
}
