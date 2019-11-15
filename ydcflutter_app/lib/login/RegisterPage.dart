import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/services.dart';//导入网络请求相关的包
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ydcflutter_app/main/MainPage.dart';
import 'package:ydcflutter_app/utils/YDCLoading.dart';
import 'package:ydcflutter_app/utils/YDCVerify.dart';
import 'package:ydcflutter_app/httpservice/ydc_httpmanager.dart';
import 'package:ydcflutter_app/datarepository/ydc_sharedpreferences.dart';
import 'package:ydcflutter_app/config/SharePreferenceKey.dart';
import 'package:ydcflutter_app/config/ApiConfig.dart';
import 'package:ydcflutter_app/login/bean/LoginBean.dart';
import 'package:ydcflutter_app/config/Constant.dart';

/**
 * 注册
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class RegisterPage extends StatefulWidget {
  @override
  State createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var mContext=null;
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  bool _checkSelected = false;//维护复选框开关状态

  var _userName = "";
  var _password = "";
  var _code = "";
  var _email="";

  bool _correctPhone = true;
  bool _correctPassword = true;


  int _seconds = 0;
  String _verifyStr = '获取验证码';
  Timer _timer;

  _startTimer() {
    _seconds = 120;

    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        return;
      }

      _seconds--;
      _verifyStr = '$_seconds'+'s后重发';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新获验证码';
      }
    });
  }

  _cancelTimer() {
    _timer?.cancel();
  }


  void _getCode() async {
    YDCLoadingPage loadingPage = YDCLoadingPage(mContext);
    loadingPage.show();
    var params = {
      'appid': Constant.appId,
      'appsecret':Constant.SECRETKEY,
      'username': _userName,
      'type': '1000'
    };
    httpManager.clearAuthorization();
    var res = await httpManager.request(
        ApiConfig.BASE_URL+ApiConfig.getcode, params, null, new Options(method: "post"));
    if (res != null ) {
      if (Constant.DEBUG) {
        final data = json.decode(res.data.toString());
        var code= data['code'];
        var message= data['message'];
        if(code=="1000"){
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

    }else{

      Future.delayed(
        Duration(seconds: 2),
            () {
          loadingPage.close();
          setState(() {
            Fluttertoast.showToast(
                msg: res.data.toString(),
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

  void _registerHttp() async {
    YDCLoadingPage loadingPage = YDCLoadingPage(mContext);
    loadingPage.show();
    var params = {
      'appid': Constant.appId,
      'appsecret':Constant.SECRETKEY,
      'username': _userName,
      'password': _password,
      "verificationcode":_code,
      "developer":"个人",
      "email":_email
    };
    httpManager.clearAuthorization();
    var res = await httpManager.request(
        ApiConfig.BASE_URL+ApiConfig.REGISTER, params, null, new Options(method: "post"));
    if (res != null ) {
      if (Constant.DEBUG) {
        print("user result");
        print(res);
        print(res.data.toString());
        final data = json.decode(res.data.toString());
        var code= data['code'];
        var message= data['message'];
        if(code=="1000"){
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
                Navigator.of(context).pop();


              });
            },
          );

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
  Widget build(BuildContext context) {
    // TODO: implement build
    mContext=context;

    Widget phoneInputWidget = new Container(
      margin: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      width: MediaQuery
          .of(context)
          .size
          .width * 0.85,
      child:
      new TextField(
          controller: _phoneController,
          maxLines: 1,
          onChanged: (String value){
            _userName=value;
          },
          style: new TextStyle(fontSize: 16.0, color: Colors.black),
          //键盘展示为号码
          keyboardType: TextInputType.phone,
          //只能输入数字
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly,
          ],
          decoration: new InputDecoration(
            hintText: '请输入手机号码',
            errorText: _correctPhone
                ? null
                : '请输入正确的手机号',
            icon: new Image.asset(
              'static/images/phone_icon.png',
              width: 20.0,
              height: 20.0,
            ),
            border: UnderlineInputBorder(),
          ),
          onSubmitted: (value) {
            _checkInput();
          }
      ),
    );
    Widget passwordInputWidget = new Container(
      margin: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      width: MediaQuery
          .of(context)
          .size
          .width * 0.85,
      child:
      new TextField(
          obscureText: true,
          keyboardType: TextInputType.number,
          controller: _passwordController,
          style: new TextStyle(fontSize: 16.0, color: Colors.black),
          decoration: new InputDecoration(
            hintText: '请输入密码',
            errorText: _correctPassword
                ? null
                : '请输入正确的密码',
            icon: new Image.asset(
              'static/images/password_icon.png',
              width: 20.0,
              height: 20.0,
            ),
            border: UnderlineInputBorder(),
          ),
          onChanged:(String value){
            _password=value;
          }
      ),
    );

    Widget emailInputWidget=new Padding(
      padding: new EdgeInsets.only(right: 20.0),
      child:
      new TextField(
        keyboardType: TextInputType.text,
        maxLines: 1,
        //controller: _passwordController,
        style: new TextStyle(fontSize: 16.0, color: Colors.black),
        decoration:new InputDecoration(
          hintText: '请输入邮箱',
//          errorText: _correctPassword
//              ? null
//              : '请输入正确的验证码',
          icon: new Image.asset(
            'images/iv_vercode.png',
            width: 20.0,
            height: 20.0,
          ),
        ),

        onChanged: (String value){
          _email=value;
        },
      ),
    );


    Widget codeInputWidget=new Padding(
      padding: new EdgeInsets.only(right: 20.0),
      child:
      new TextField(
        keyboardType: TextInputType.number,
        maxLines: 1,
        //controller: _passwordController,
        style: new TextStyle(fontSize: 16.0, color: Colors.black),
        decoration:new InputDecoration(
          hintText: '请输入验证码',
          errorText: _correctPassword
              ? null
              : '请输入正确的验证码',
          icon: new Image.asset(
            'images/iv_vercode.png',
            width: 20.0,
            height: 20.0,
          ),
        ),

        onChanged: (String value){
          _code=value;
        },
      ),
    );


    Widget codeBtnWidget = new InkWell(
      onTap: (_seconds == 0)
          ? () {
        if (_userName == null || _userName.length == 0) {
          Fluttertoast.showToast(
              msg: "账号不能为空！",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
          return;
        }else{
          if(!YDCVerify.isPhone(_userName)){
            Fluttertoast.showToast(
                msg: "请输入正确的手机号码！",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

            );
            return;
          }
        }
        _getCode();

        setState(() {
          _startTimer();
        });
      }
          : null,
      child: new Container(
        alignment: Alignment.center,
        width: 120.0,
        height: 36.0,
        decoration: new BoxDecoration(
          border: new Border.all(
            width: 1.0,
            color: Colors.white,
          ),
        ),
        child: new Text(
          '$_verifyStr',
          style: new TextStyle(fontSize: 14.0,color: const Color(0xFFe9546b) ),
        ),
      ),
    );

    Widget  codeWidget=new Padding(
      padding: new EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 0.0),
      child: new Stack(
        children: <Widget>[
          codeInputWidget,
          new Align(
            alignment: Alignment.topRight,
            child: codeBtnWidget,
          ),
        ],
      ),
    );



    void _submitAction(){
        if (_userName == null || _userName.length == 0) {
          Fluttertoast.showToast(
              msg: "账号不能为空！",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
          return;
        }else{
          if(!YDCVerify.isPhone(_userName)){
            Fluttertoast.showToast(
                msg: "请输入正确的手机号码！",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

            );
            return;
          }
        }
        if (_password == null || _password.length == 0) {
          Fluttertoast.showToast(
              msg: "密码不能为空！",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
          return;
        }else{
          if(_password.length<6){
            Fluttertoast.showToast(
                msg: "请输入6位以上的密码！",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

            );
            return;
          }
        }
        if (_code == null || _code.length == 0) {
          Fluttertoast.showToast(
              msg: "验证码不能为空！",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
          return;
        }
        if (_email == null || _email.length == 0) {
          Fluttertoast.showToast(
              msg: "邮箱不能为空！",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
          return;
        }

      if(_checkSelected){
        _registerHttp();
      }else{
        Fluttertoast.showToast(
            msg: "请勾选协议！",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

        );
        return;
      }
    }


    Widget btnLoginWidget = new FlatButton(

        onPressed: () {
          _submitAction();
        },

        child: new Container(
          height: 45.0,
          margin: new EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
              gradient: new LinearGradient(
                  colors: [const Color(0xFFe9546b), const Color(0xFFd0465b)])
          ),
          child: new Center(
              child: new Text(
                "确 定",
                textScaleFactor: 1.1,
                style: new TextStyle(fontSize: 16.0, color: Colors.white),
              )),
        ));




    TextStyle descTextStyle = new TextStyle(
      color: const Color(0xFF999999),
      fontSize: 12.0,
    );

    Widget agreementWidget = new Container(
      padding: new EdgeInsets.all(0.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            //padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: new Checkbox(value: _checkSelected,
              activeColor: const Color(0xffe9546b),
              onChanged: (bool) {
                print(bool);
                setState(() {
                  _checkSelected=bool;
                });
              },
            ),
          ),
          new Container(
            child: new Text(" 阅读并同意xxxx",
              style: descTextStyle,),
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

            child: new Container(
              child: new Text("《用户协议》",
                style: new TextStyle(
                  color: const Color(0xffe9546b),
                  fontSize: 12.0,
                ),),
            ),

          )

        ],
      ),
    );
    Widget contentWidget= new Center(
      child: new Container(
        margin: const EdgeInsets.only(top: 20.0),
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
            phoneInputWidget,
            passwordInputWidget,
            emailInputWidget,
            codeWidget,
            btnLoginWidget,
            agreementWidget
          ],
        ),
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("注册"),
        centerTitle: true,
        elevation: 0.25,
        backgroundColor: Colors.white,
        //automaticallyImplyLeading: false, //设置没有返回按钮
      ),
      body: new Stack(
        children: <Widget>[
          bgWidget,
          new ListView(
            children: <Widget>[
              contentWidget,
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }

  void _checkInput() {
    if (_phoneController.text.isNotEmpty &&
        (_phoneController.text
            .trim()
            .length !=11)) {
      _correctPhone = false;
    } else {
      _correctPhone = true;
    }
    if (_passwordController.text.isNotEmpty &&
        _passwordController.text
            .trim()
            .length < 6) {
      _correctPassword = false;
    } else {
      _correctPassword = true;
    }
    setState(() {});
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


}
