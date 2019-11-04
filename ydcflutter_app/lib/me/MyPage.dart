import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';//导入网络请求相关的包
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ydcflutter_app/main/MainPage.dart';

class MyPage extends StatefulWidget {
  @override
  State createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String mPhoneText;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build



    void _loginAction(){
      //print("点击了按钮22");

      Fluttertoast.showToast(
          msg: "用户中心！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

      );



    }

    Widget buttonLogin = new FlatButton(

        onPressed: () {
          _loginAction();
        },

        child: new Container(
          height: 45.0,
          margin: new EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
              gradient: new LinearGradient(
                  colors: [const Color(0xFF5AA1FD), const Color(0xFF3C73F1)])
          ),
          child: new Center(
              child: new Text(
                "用户中心正在建设中...",
                textScaleFactor: 1.1,
                style: new TextStyle(fontSize: 16.0, color: Colors.white),
              )),
        ));


    void _openSignUp() {
//      setState(() {
//        Navigator.of(context).push(new MaterialPageRoute<Null>(
//          builder: (BuildContext context) {
//            return new SignUp();
//          },
//        ));
//      });
    }





    Widget whitleContent = new Center(
      child: new Container(
//        margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        constraints: new BoxConstraints.expand(width: MediaQuery
            .of(context)
            .size
            .width * 0.9, height: 450.0,),
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Colors.white, width: 5.0,),
          borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buttonLogin,



          ],
        ),
      ),
    );

    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              whitleContent,
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

  }



}