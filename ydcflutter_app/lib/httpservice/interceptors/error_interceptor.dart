import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:ydcflutter_app/httpservice/code.dart';
import 'package:ydcflutter_app/httpservice/result_data.dart';

///是否需要弹提示
const NOT_TIP_KEY = "noTip";

/**
 * 错误拦截
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptors(this._dio);

  @override
  onRequest(RequestOptions options) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(new ResultData(
          Code.errorHandleFunction(Code.NETWORK_ERROR, "", false),
          false,
          Code.NETWORK_ERROR));
    }
    return options;
  }
}
