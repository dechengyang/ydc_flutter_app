import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ydcflutter_app/eventbus/EventParam.dart';
import 'package:ydcflutter_app/httpservice/code.dart';
import 'package:ydcflutter_app/login/LoginPage.dart';
import 'package:ydcflutter_app/me/bean/User.dart';
import 'package:ydcflutter_app/test/bean/YDCState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ydcflutter_app/eventbus/YDCEventBusManage.dart';
import 'package:ydcflutter_app/eventbus/http_error_event.dart';

/**
 *
 * Created by yangdecheng
 * Date: 2019-11-04
 */

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);
class YDCFlutterApp extends StatefulWidget {
  @override
  State createState() => new _YDCFlutterAppState();
}

class _YDCFlutterAppState extends State<YDCFlutterApp> {
  var mContext=null;
  StreamSubscription _subscription;
  /// 创建Store，引用 YDCState 中的 appReducer 创建 Reducer
  /// initialState 初始化 State
  final store = new Store<YDCState>(
      appReducer,
      initialState: new YDCState(
        user: User.empty(),

      ));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听登录事件
    _subscription=eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
    _subscription.resume();
  }


  @override
  Widget build(BuildContext context) {

    mContext=context;
    // 使用 flutter_redux 做全局状态共享
    // 通过 StoreProvider 应用 store
    return new StoreProvider(
        store: store,
        child:new MaterialApp(
          title: 'ydc_flutter_shop',
//      theme: defaultTargetPlatform == TargetPlatform.iOS
//          ? kIOSTheme
//          : kDefaultTheme,
          theme: new ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.grey[50],
            scaffoldBackgroundColor: Colors.grey[50],
            dialogBackgroundColor: Colors.grey[50],
            primaryColorBrightness: Brightness.light,
            buttonColor: Colors.blue,
            iconTheme: new IconThemeData(
              color: Colors.grey[700],
            ),
            hintColor: Colors.grey[400],
          ),
          onGenerateRoute: (RouteSettings settings){
            return MaterialPageRoute(builder: (context){
              String routeName = settings.name;
              print("66"+routeName);
            });
          },
          navigatorObservers:[MyObserver(),] ,
          home:  new LoginPage(),
        ));
  }


  @override
  void dispose() {
    super.dispose();
    if(_subscription!=null){
      //eventBus.destroy();
      //_subscription.resume();  //  开
      //_subscription.pause();    //  暂停
      _subscription.cancel();   //  取消
      _subscription=null;
    }
  }

}


//继承NavigatorObserver
class MyObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route previousRoute) {
    // 当调用Navigator.push时回调
    super.didPush(route, previousRoute);
    //可通过route.settings获取路由相关内容
    //route.currentResult获取返回内容
    //....等等
    print(route.settings.name);
  }
}


///网络错误提醒
errorHandleFunction(int code, message) {
  switch (code) {
    case Code.NETWORK_ERROR:
      Fluttertoast.showToast(
          msg: "网络错误");
      break;
    case 401:
      Fluttertoast.showToast(
          msg: "网络错误401");
      break;
    case 403:
      Fluttertoast.showToast(
          msg: "网络错误403");
      break;
    case 404:
      Fluttertoast.showToast(
          msg: "网络错误404");
      break;
    case Code.NETWORK_TIMEOUT:
    //超时
      Fluttertoast.showToast(
          msg: "请求超时");
      break;
    default:
      Fluttertoast.showToast(
          msg: "network_error_unknown:"+code.toString());
      break;
  }
}
