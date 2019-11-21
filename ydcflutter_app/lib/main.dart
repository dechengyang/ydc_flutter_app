import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ydcflutter_app/login/LoginPage.dart';
import 'package:ydcflutter_app/me/bean/User.dart';
import 'package:ydcflutter_app/test/bean/YDCState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => runApp( new YDCApp());

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class YDCApp  extends StatelessWidget {
  /// 创建Store，引用 YDCState 中的 appReducer 创建 Reducer
  /// initialState 初始化 State
  final store = new Store<YDCState>(
      appReducer,
      initialState: new YDCState(
        user: User(""),

      ));
  YDCApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
