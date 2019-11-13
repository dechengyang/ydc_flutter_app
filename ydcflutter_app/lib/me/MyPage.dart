import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';//导入网络请求相关的包
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ydcflutter_app/common/CommonPage.dart';
import 'dart:convert';
import 'package:ydcflutter_app/utils/ydc_loading_page.dart';

import 'package:ydcflutter_app/config/SharePreferenceKey.dart';
import 'package:ydcflutter_app/datarepository/ydc_sharedpreferences.dart';
import 'package:ydcflutter_app/common/CommonPage.dart';

class MyPage extends StatefulWidget {
  @override
  State createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> {

  BuildContext mContext;

  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String mPhoneText;

  String data;
  void _getDio() async {
//    YDCLoadingPage loadingPage = YDCLoadingPage(context);
//    loadingPage.show();
    String token = await SharedPreferencesHelper.get(SharePreferenceKey.TOKEN_KEY);
    if (token == null) {
      print("getToken ====== "+token);
    }
    Response response =
    await Dio().get("https://www.runoob.com/try/ajax/json_demo.json");
    print("get ====== "+response.toString());
    final body = json.decode(response.toString());

    setState(() {
      data = body['name'];
      print("title ====== "+data);
    });

    //loadingPage.close();
  }

  void _postDio() async {

    String token = await SharedPreferencesHelper.get(SharePreferenceKey.TOKEN_KEY);
    if (token == null) {
      print("getToken ====== "+token);
    }else{
      print("getToken ====== "+token);
    }

//    YDCLoadingPage loadingPage = YDCLoadingPage(context);
//    loadingPage.show();
    var headers = Map<String, String>();
    headers['loginSource'] = 'Android';
    headers['useVersion'] = '3.1.0';
    headers['isEncoded'] = '1';
    headers['bundleId'] = 'com.nongfadai.iospro';
    headers['Content-Type'] = 'application/json';

    Dio dio = Dio();
    dio.options.baseUrl = "http://api.juheapi.com/japi/toh";
    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;
    dio.options.headers.addAll(headers);
    dio.options.method = 'post';

    var params = {
      'v': '1.0',
      'month': '7',
      'day': '25',
      'key': 'bd6e35a2691ae5bb8425c8631e475c2a'
    };

    Options option = Options(method: 'post');
    Response response = await dio.post("http://api.juheapi.com/japi/toh",
        /*data: {
          "v": "1.0",
          "month": "7",
          "day": "25",
          "key": "bd6e35a2691ae5bb8425c8631e475c2a"
        },*/
        data: params,
        options: option);

    if (response.statusCode == 200) {
      debugPrint('===请求求url: ${response.request.uri.toString()}');
      debugPrint('===请求headler: ${response.request.headers}');
      debugPrint('===请求结果: \n${response.data}\n');
      //loadingPage.close();
    } else {
      print('请求失败');
      //loadingPage.close();
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getDio();
   // _postDio();
  }

  @override
  Widget build(BuildContext context) {
    mContext=context;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("我的"),
        centerTitle: true,
        elevation: 0.25,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, //设置没有返回按钮
      ),
      body:new Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              personInfoWidget,
              topMenuWidget,
              orderWidget,
              integralWidget,
              dividerWidget,
              walletWidget,
              dividerWidget,
              aboutWidget,
              dividerWidget,
              settingWidget,
            new Container(
                color: const Color(0xFFFFFFFF),
                height: 50.0,
                child:new InkWell(
                  onTap: () {

                    Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new CommomPage();
                      },
                    ));

                  },
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: new Image.asset("static/images/setting_icon.png",
                                width: 20.0,
                                height: 20.0,)),

                          new Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: new Text("常用功能",
                                style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),

                        ],
                      ),

                      new Row(
                        children: <Widget>[
                          new Padding(
                              padding: const EdgeInsets.only(right: 15.0,left: 10.0),
                              child: new Image.asset("static/images/enter.png",
                                  width: 16.0,
                                  height: 16.0)),
                        ],
                      )
                    ],
                  ),
                )
            ),
              dividerWidget,
              walletWidget,
              dividerWidget,
              walletWidget,

            ],
          )
        ],
      ),

    );
  }



  Widget bgWidget = new Opacity(

      opacity: 0.98,
      child: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('static/images/login_back.png'),
            fit: BoxFit.cover,
          ),
        ),
      )
  );

  Widget personInfoWidget=new Container(
      decoration:  new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('static/images/personinfo_head_bg.png'),
            fit: BoxFit.cover,),
      ),
      margin: const EdgeInsets.only( bottom: 10.0),
      //color: Colors.white,
      child: new InkWell(
        onTap: () {
          Fluttertoast.showToast(
              msg: "正在建设中...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
        },

        child:new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Padding(
                padding: const EdgeInsets.only(left: 20.0,top: 30.0,
                    bottom: 30.0),
                child: new Image.asset("static/images/head_portrait.png",
                  width: 60.0,
                  height: 60.0,)),
            new Stack(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: new Text("西南黑少",
                      style: new TextStyle(fontSize: 20.0, color:const Color(0xFFffffff)),)),

                new Padding(
                    padding: const EdgeInsets.only(left: 20.0,top: 29.0),
                    child: new Text("187****4888",
                      style: new TextStyle(fontSize: 12.0,
                          color:const Color(0xFFffffff)),)),

                new Padding(
                    padding: const EdgeInsets.only(left: 20.0,top: 50.0),
                    child: new Text("xxxx有限公司",
                      style: new TextStyle(fontSize: 12.0,
                          color:const Color(0xFFffffff)),)),

              ],),
          ],
        ),


      )

  );



  Widget topMenuWidget=new Container(
      padding: const EdgeInsets.only( bottom: 10.0),
      margin: const EdgeInsets.only( bottom: 10.0),
      color: Colors.white,
        child:new Row(
          //水平方向填充
          mainAxisSize: MainAxisSize.max,
          //平分空白
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[

        Expanded(
            flex: 1,
            child:
            new GestureDetector(
                onTap: (){
                  Fluttertoast.showToast(
                      msg: "正在建设中...",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                  );
                },
                child:
            new Column(
                mainAxisSize: MainAxisSize.min,
             children: <Widget>[
              new Padding(
               padding: const EdgeInsets.only(left: 0.0),
               child: new Image.asset("static/images/vip.png",
                width: 30.0,
                height: 30.0,)),
              new Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: new Text("会员卡",
                style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
             ]
        ))),    Expanded(
    flex: 1,
    child:
    new GestureDetector(
        onTap: (){
          Fluttertoast.showToast(
              msg: "正在建设中...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
        },
        child:new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: new Image.asset("static/images/coupon.png",
                          width: 30.0,
                          height: 30.0,)),
                    new Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Text("优惠券",
                          style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                  ]
              ))),   Expanded(
    flex: 1,
    child:
    new GestureDetector(
        onTap: (){
          Fluttertoast.showToast(
              msg: "正在建设中...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
        },
        child:
        new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: new Image.asset("static/images/shopping_cart.png",
                          width: 30.0,
                          height: 30.0,)),
                    new Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Text("购物车",
                          style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                  ]
              ))),   Expanded(
    flex: 1,
    child:
    new GestureDetector(
        onTap: (){
          Fluttertoast.showToast(
              msg: "正在建设中...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
        },
        child:
        new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: new Image.asset("static/images/my_collect.png",
                          width: 30.0,
                          height: 30.0,)),
                    new Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Text("收藏",
                          style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                  ]
              )))],
    )


  );




  Widget orderWidget=new Container(
      padding: const EdgeInsets.only( bottom: 10.0,top: 10.0),
      margin: const EdgeInsets.only( bottom: 10.0),
      color: Colors.white,
      child:new Column(
        //水平方向填充
        mainAxisSize: MainAxisSize.max,
        //平分空白
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(

                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.only(top: 0.0,bottom: 15.0,left: 15.0),
                      child: new Text("我的订单",
                        style: new TextStyle(fontWeight: FontWeight.w700  ,fontSize: 14.0, color:const Color(0xFF333333)),)),

                ],
              ),
              new GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(
                        msg: "正在建设中...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                    );
                  },
                  child:
                    new Row(
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(left: 8.0,bottom: 15.0),
                            child: new Text("查看全部订单",
                              style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                        new Padding(
                            padding: const EdgeInsets.only(right: 15.0,left: 10.0,bottom: 15.0),
                            child: new Image.asset("static/images/enter.png",
                                width: 16.0,
                                height: 16.0)),
                      ],
                    ))
            ],
          ),

          new Row( children: <Widget>[
          Expanded(
              flex: 1,
              child:
              new GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(
                        msg: "正在建设中...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                    );
                  },
                  child:
                  new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: new Image.asset("static/images/wallet.png",
                              width: 30.0,
                              height: 30.0,)),
                        new Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: new Text("待付款",
                              style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                      ]
                  ))),  Expanded(
              flex: 1,
              child:
              new GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(
                        msg: "正在建设中...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                    );
                  },
                  child:new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: new Image.asset("static/images/daifahuo_icon.png",
                              width: 30.0,
                              height: 30.0,)),
                        new Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: new Text("待发货",
                              style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                      ]
                  ))),   Expanded(
              flex: 1,
              child:
              new GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(
                        msg: "正在建设中...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                    );
                  },
                  child:new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: new Image.asset("static/images/receiving.png",
                              width: 30.0,
                              height: 30.0,)),
                        new Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: new Text("待收货",
                              style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                      ]
                  ))),   Expanded(
              flex: 1,
              child:
              new GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(
                        msg: "正在建设中...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                    );
                  },
                  child:
                  new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: new Image.asset("static/images/evaluate.png",
                              width: 30.0,
                              height: 30.0,)),
                        new Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: new Text("待评价",
                              style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                      ]
                  ))),   Expanded(
              flex: 1,
              child:
              new GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(
                        msg: "正在建设中...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                    );
                  },
                  child:
                  new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: new Image.asset("static/images/aftersale.png",
                              width: 30.0,
                              height: 30.0,)),
                        new Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: new Text("退款/售后",
                              style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                      ]
                  )))],
      )])


  );

  Widget dividerWidget=new Container(
      //margin: const EdgeInsets.only( left: 10.0,right: 10.0),
      child: new Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15.0),
          child:
          new Divider(height: 1.0,indent: 0.0,color: Color(0xFFe5e5e5))
          )

  );
  Widget integralWidget=new Container(
      color: const Color(0xFFFFFFFF),
      height: 50.0,
      child:new InkWell(
        onTap: () {
          Fluttertoast.showToast(
              msg: "正在建设中...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
        },
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: new Image.asset("static/images/my_points.png",
                      width: 20.0,
                      height: 20.0,)),

                new Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text("我的积分",
                      style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),

              ],
            ),

            new Row(
              children: <Widget>[
                 new Padding(
                  padding: const EdgeInsets.only(left: 10.0,bottom: 0.0),
                  child: new Text("1000.00",
                  style: new TextStyle(fontSize: 14.0, color:const Color(0xFF888888)),))
                ,new Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 10.0),
                    child: new Image.asset("static/images/enter.png",
                        width: 16.0,
                        height: 16.0)),
              ],
            )
          ],
        ),
      )
  );
  Widget walletWidget=new Container(
      color: const Color(0xFFFFFFFF),
      height: 50.0,
      child:new InkWell(
        onTap: () {
          Fluttertoast.showToast(
              msg: "正在建设中...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
        },
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: new Image.asset("static/images/account_balance.png",
                      width: 20.0,
                      height: 20.0,)),

                new Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text("我的钱包",
                      style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),

              ],
            ),

            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 10.0),
                    child: new Image.asset("static/images/enter.png",
                        width: 16.0,
                        height: 16.0)),
              ],
            )
          ],
        ),
      )
  );
  Widget aboutWidget=new Container(
      color: const Color(0xFFFFFFFF),
      height: 50.0,
      child:new InkWell(
        onTap: () {
          Fluttertoast.showToast(
              msg: "正在建设中...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
        },
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: new Image.asset("static/images/about.png",
                      width: 20.0,
                      height: 20.0,)),

                new Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text("关于我们",
                      style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),

              ],
            ),

            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 10.0),
                    child: new Image.asset("static/images/enter.png",
                        width: 16.0,
                        height: 16.0)),
              ],
            )
          ],
        ),
      )
  );

  Widget settingWidget=new Container(
      color: const Color(0xFFFFFFFF),
      height: 50.0,
      child:new InkWell(
        onTap: () {
          Fluttertoast.showToast(
              msg: "正在建设中...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
        },
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: new Image.asset("static/images/setting_icon.png",
                      width: 20.0,
                      height: 20.0,)),

                new Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text("设置",
                      style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),

              ],
            ),

            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 10.0),
                    child: new Image.asset("static/images/enter.png",
                        width: 16.0,
                        height: 16.0)),
              ],
            )
          ],
        ),
      )
  );



  @override
  void dispose() {
    super.dispose();

  }



}