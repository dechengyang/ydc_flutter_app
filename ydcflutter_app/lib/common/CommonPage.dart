import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';//导入网络请求相关的包
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ydcflutter_app/common/DialogPage.dart';
import 'package:ydcflutter_app/test/EventBusTestPage1.dart';
import 'package:ydcflutter_app/test/MethodChannelPageTest.dart';
import 'package:ydcflutter_app/test/TestPage.dart';
import 'package:ydcflutter_app/test/TestPage2.dart';
import 'package:ydcflutter_app/test/TestReduxPage.dart';

class CommomPage extends StatefulWidget {
  @override
  State createState() => new _CommomPageState();
}

class _CommomPageState extends State<CommomPage> {
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String mPhoneText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("常用功能"),
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

                      Navigator.of(context).push(new MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return new DialogPage();
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
                                child: new Image.asset("static/images/account_balance.png",
                                  width: 20.0,
                                  height: 20.0,)),


                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("各种对话框",
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
              new Container(
                  color: const Color(0xFFFFFFFF),
                  height: 50.0,
                  child:new InkWell(
                    onTap: () {

                      Navigator.of(context).push(new MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return new TestPage();
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
                                child: new Image.asset("static/images/account_balance.png",
                                  width: 20.0,
                                  height: 20.0,)),


                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("TEST",
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
              new Container(
                  color: const Color(0xFFFFFFFF),
                  height: 50.0,
                  child:new InkWell(
                    onTap: () {

                      Navigator.of(context).push(new MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return new TestReduxPage();
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
                                child: new Image.asset("static/images/account_balance.png",
                                  width: 20.0,
                                  height: 20.0,)),


                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("TEST_REDUX",
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
              new Container(
                  color: const Color(0xFFFFFFFF),
                  height: 50.0,
                  child:new InkWell(
                    onTap: () {

                      Navigator.of(context).push(new MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return new EventBusTestPage();
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
                                child: new Image.asset("static/images/account_balance.png",
                                  width: 20.0,
                                  height: 20.0,)),


                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("TEST_EventBus",
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
              new Container(
                  color: const Color(0xFFFFFFFF),
                  height: 50.0,
                  child:new InkWell(
                    onTap: () {

                      Navigator.of(context).push(new MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return new TestMethodChannelPage();
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
                                child: new Image.asset("static/images/account_balance.png",
                                  width: 20.0,
                                  height: 20.0,)),


                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("测试平台通道",
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
            ],
          )
        ],
      ),

    );
  }


  Widget dividerWidget=new Container(
    //margin: const EdgeInsets.only( left: 10.0,right: 10.0),
      child: new Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15.0),
          child:
          new Divider(height: 1.0,indent: 0.0,color: Color(0xFFe5e5e5))
      )

  );


  @override
  void dispose() {
    super.dispose();

  }



}