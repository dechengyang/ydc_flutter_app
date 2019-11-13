import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';//导入网络请求相关的包
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:ydcflutter_app/utils/ydc_loading_page.dart';

import 'package:ydcflutter_app/config/SharePreferenceKey.dart';
import 'package:ydcflutter_app/datarepository/ydc_sharedpreferences.dart';

class DialogPage extends StatefulWidget {
  @override
  State createState() => new _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {

  BuildContext mContext;
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String mPhoneText;


  List<String> nameItems = <String>[
    '微信',
    '朋友圈',
    'QQ',
    'QQ空间',
    '微博',
    'FaceBook',
    '邮件',
    '链接'
  ];

// 这个urlItems这里没有用到
  List<String> urlItems = <String>[
    'static/images/mx_wx.png',
    'static/images/store.png',
    'static/images/mx_qq.png',
    'static/images/mx_wx.png',
    'static/images/mx_qq.png',
    'static/images/mx_qq.png',
    'static/images/mx_wx.png',
    'static/images/mx_qq.png'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mContext=context;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("对话框案例"),
        centerTitle: true,
        elevation: 0.25,
        backgroundColor: Colors.white,
        //automaticallyImplyLeading: false, //设置没有返回按钮
      ),
      body:new Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[

              new Container(
                  color: const Color(0xFFFFFFFF),
                  height: 50.0,
                  child:new InkWell(
                    onTap: () {
                      takephotosDialogWidget(context);
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[

                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("拍照对话框",
                                  style: new TextStyle(fontSize: 16.0, color:const Color(0xFF333333)),)),

                          ],
                        ),

                        new Row(
                          children: <Widget>[


                          ],
                        )
                      ],
                    ),
                  )
              ),
              dividerWidget,

              new Container(
                  color: const Color(0xFFFFFFFF),
                  height: 50.0,
                  child:new InkWell(
                    onTap: () {
                      shareDialogWidget(context);
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[

                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("分享对话框",
                                  style: new TextStyle(fontSize: 16.0, color:const Color(0xFF333333)),)),

                          ],
                        ),

                        new Row(
                          children: <Widget>[


                          ],
                        )
                      ],
                    ),
                  )
              ),


            ],
          )
        ],
      ),

    );
  }



  Widget dividerWidget=new Container(
    //margin: const EdgeInsets.only( left: 10.0,right: 10.0),
      child: new Padding(
          padding: const EdgeInsets.only(left: 0.0,right: 0.0),
          child:
          new Divider(height: 1.0,indent: 0.0,color: Color(0xFFe5e5e5))
      )

  );

  shareDialogWidget(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return _shareWidget();
        });
  }
  Widget _shareWidget() {
    return new Container(
      height: 250.0,
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: new Container(
              height: 190.0,
              child: new GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 1.0),
                itemBuilder: (BuildContext context, int index) {
                  return  new InkWell(
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
                      child:new Column(
                      children: <Widget>[
                      new Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                          child: new Image.asset(urlItems[index],
                             width: 30.0,
                             height: 30.0,)),
                      new Text(nameItems[index])
                    ],
                  ));
                },
                itemCount: nameItems.length,
              ),
            ),
          ),
          new Container(
            height: 0.5,
            color: Colors.blueGrey,
          ),
          new Center(
            child: new Padding(
              padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
              child: GestureDetector(
                  onTap:(){
                    Navigator.of(context).pop();
                  },
                  child: new Text(
                    '取  消',
                    style: new TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                  )),
            ),
          ),
        ],
      ),
    );

  }
  takephotosDialogWidget(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.photo_camera),
                title: new Text("拍照"),
                onTap: () async {
                  Navigator.pop(context);
                },
              ),
              dividerWidget,
              new ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text("选择相册"),
                onTap: () async {
                  Navigator.pop(context);
                },
              ),

              dividerWidget,

              new Container(
                  child: new InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: new Padding(
                        padding: const EdgeInsets.only(left: 0.0,top: 10.0,bottom: 10.0),
                        child: new Text("取消",
                          style: new TextStyle(fontSize: 18.0,
                              color:const Color(0xFFaaaaaa)),)),
                  )
              ),
            ],
          );
        }
    );
  }

  @override
  void dispose() {
    super.dispose();

  }



}