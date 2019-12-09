import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';//导入网络请求相关的包
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:ydcflutter_app/common/CommonPage.dart';
import 'dart:convert';
import 'package:ydcflutter_app/config/SharePreferenceKey.dart';
import 'package:ydcflutter_app/datarepository/ydc_sharedpreferences.dart';
import 'package:ydcflutter_app/httpservice/ydc_httpmanager.dart';
import 'package:ydcflutter_app/config/ApiConfig.dart';
import 'package:ydcflutter_app/config/Constant.dart';
import 'package:ydcflutter_app/me/bean/UserFeed.dart';
import 'package:ydcflutter_app/utils/YDCLoading.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class MyPage extends StatefulWidget {
  @override
  State createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> {

  BuildContext mContext;
  UserInfoBean _user;
  var _image;

  void _getData() async {
    String token = await SharedPreferencesHelper.get(SharePreferenceKey.TOKEN_KEY);
    if (token == null) {
      print("getToken ====== ");
      print(token);
      print("getToken2 ====== ");
    }
    YDCLoadingPage loadingPage = YDCLoadingPage(mContext);
    loadingPage.show();
    var params = {
      'appid': Constant.appId,
      'appsecret':Constant.SECRETKEY,
      'token': token
    };
    httpManager.clearAuthorization();
    var res = await httpManager.request(
        ApiConfig.BASE_URL+ApiConfig.getUserinfo, params, null, new Options(method: "post"));
    if (res != null ) {
      if (Constant.DEBUG) {
        print("my_result======"+res.data.toString());
        final data = json.decode(res.data.toString());
        var code= data['code'];
        var message= data['message'];
        if(code=="1000"){
          var feed=UserFeed.fromJson(data);
           UserInfoBean user=feed.data;
           setState(() {
             _user=user;
           });
           loadingPage.close();
        }else{
          Future.delayed(
            Duration(seconds: 2),
                () {
              loadingPage.close();
              setState(() {
                Fluttertoast.showToast(
                    msg: message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                );


              });
            },
          );
        }

      }

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       _getData();
  }

  @override
  Widget build(BuildContext context) {
    mContext=context;
    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("我的"),
//        centerTitle: true,
//        elevation: 0.25,
//        backgroundColor: Colors.white,
//        automaticallyImplyLeading: false, //设置没有返回按钮
//      ),
      body:new Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              getPersonInfoWidget(_user, context),
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

  void showActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value != null) {
        if(value == "Camera"){
          getImageByCamera();
        }else if(value == "Gallery"){
         getImageByGallery();
        }
      }
    });
  }

  Future getImageByGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future getImageByCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  getPersonInfoWidget(user ,context){
    return new Container(
        decoration:  new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('static/images/personinfo_head_bg.png'),
            fit: BoxFit.cover,),
        ),
        margin: const EdgeInsets.only( bottom: 10.0),
        //color: Colors.white,
        child: new InkWell(
          onTap: () {
//            Fluttertoast.showToast(
//                msg: "正在建设中...",
//                toastLength: Toast.LENGTH_SHORT,
//                gravity: ToastGravity.BOTTOM,
//                timeInSecForIos:1
////            backgroundColor: Color(0xe74c3c),
////            textColor: Color(0xffffff)
//
//            );
            showActionSheet(
              context: context,
              child: CupertinoActionSheet(
                title: const Text('拍照'),
                //message: const Text('Please select the best mode from the options below.'),
                actions: <Widget>[
                  CupertinoActionSheetAction(
                    child: const Text('相册'),
                    onPressed: () {
                      Navigator.pop(context, 'Gallery');
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: const Text('相机'),
                    onPressed: () {
                      Navigator.pop(context, 'Camera');
                    },
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: const Text('取消'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                ),
              ),
            );
          },

          child:new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.only(left: 20.0,top: 30.0,
                      bottom: 30.0),
                  child: _image == null?new Image.asset("static/images/head_portrait.png",
                    width: 60.0,
                    height: 60.0,):new ClipOval(child:Image.file(_image, width: 60.0,
                      height: 60.0,  fit: BoxFit.fitWidth))),
              new Stack(
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: new Text("西南黑少",
                        style: new TextStyle(fontSize: 20.0, color:const Color(0xFFffffff)),)),

                  new Padding(
                      padding: const EdgeInsets.only(left: 20.0,top: 29.0),
                      child: new Text(_user==null?"187****4888":_user.username,
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

  }


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