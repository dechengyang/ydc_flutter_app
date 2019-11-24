import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/services.dart';//导入网络请求相关的包
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ydcflutter_app/httpservice/code.dart';
import 'package:ydcflutter_app/main/MainPage.dart';
import 'package:ydcflutter_app/utils/YDCLoading.dart';
import 'package:ydcflutter_app/utils/YDCVerify.dart';
import 'package:ydcflutter_app/login/RegisterPage.dart';
import 'package:ydcflutter_app/httpservice/ydc_httpmanager.dart';
import 'package:ydcflutter_app/datarepository/ydc_sharedpreferences.dart';
import 'package:ydcflutter_app/config/SharePreferenceKey.dart';
import 'package:ydcflutter_app/config/ApiConfig.dart';
import 'package:ydcflutter_app/login/bean/LoginBean.dart';
import 'package:ydcflutter_app/config/Constant.dart';
import 'package:ydcflutter_app/eventbus/YDCEventBusManage.dart';
import 'package:ydcflutter_app/eventbus/http_error_event.dart';

/**
 * 登录
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class LoginPage extends StatefulWidget {
  @override
  State createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var mContext=null;
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  bool _checkSelected = false;//维护复选框开关状态
  bool _loginType=true;//是否是账号密码登录

  var _userName = "";
  var _password = "";
  var _code = "";

  bool _correctPhone = true;
  bool _correctPassword = true;


  int _seconds = 0;
  String _verifyStr = '获取验证码';
  String _loginTypeChangeStr='手机快捷登录';
  Timer _timer;

  _startTimer() {
    _seconds = 10;

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
  void _loginHttp() async {
    YDCLoadingPage loadingPage = YDCLoadingPage(mContext);
    loadingPage.show();
    var params = {
      'appid': Constant.appId,
      'appsecret':Constant.SECRETKEY,
      'username': _userName,
      'password': _password
    };
    httpManager.clearAuthorization();
    var res = await httpManager.request(
        ApiConfig.BASE_URL+ApiConfig.LOGIN, params, null, new Options(method: "post"));
    if (res != null ) {
      try{
        if (Constant.DEBUG) {
          print("user result");
          print(res);
          print(res.data.toString());
          final response = json.decode(res.data.toString());
          var code= response['code'];
          var message= response['message'];
          if(code=="1000"){
            loadingPage.close();
            var data= response['data'];
            var token= data['token'];
            await SharedPreferencesHelper.save(SharePreferenceKey.TOKEN_KEY, token);
            Future.delayed(
              Duration(seconds: 2),
                  () {
                setState(() {
                  Fluttertoast.showToast(
                      msg: "登录成功！",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                  );
                  if(mContext!=null) {
                    Navigator.of(mContext).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new MainPage();
                      },
                    ));
                  }


                });
              },
            );

          }else{
            Future.delayed(
              Duration(seconds: 2),
                  () {
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
      }catch(e){
       // eventBus.fire(new HttpErrorEvent(Code.NETWORK_ERROR, "登录时网络错误"));
        Fluttertoast.showToast(
            msg: "登录失败,请联系作者!");
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

    Widget codeInputWidget=new Padding(
      padding: new EdgeInsets.only(right: 20.0),
      child:
      new TextField(
        keyboardType: TextInputType.number,
        maxLines: 1,
        controller: _passwordController,
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



    void _loginAction(){

      if(_loginType){
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
      }else{
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
      }


      if(_checkSelected){
       _loginHttp();
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

    void _fasterLoginAction(){
      setState(() {
        _loginType=!_loginType;

      });
      if(_loginType){
        _loginTypeChangeStr="手机快捷登录";
      }else{
        _loginTypeChangeStr="账号密码登录";
      }

      print(_loginType);

    }

    Widget btnLoginWidget = new FlatButton(

        onPressed: () {
          _loginAction();
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
                "登 录",
                textScaleFactor: 1.1,
                style: new TextStyle(fontSize: 16.0, color: Colors.white),
              )),
        ));



    Widget fasterLoginWidget =
    new Container(
      padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: new FlatButton(
          onPressed: (){
            _fasterLoginAction();
          },
          child: new Text('$_loginTypeChangeStr',
              style: new TextStyle(fontSize: 14.0,
                color: const Color(0xFFe9546b),
              )
          )),
    );


    TextStyle descTextStyle = new TextStyle(
      color: const Color(0xFF999999),
      fontSize: 12.0,
    );

    void _signUpAction() {
      setState(() {
        Navigator.of(context).push(new MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return new RegisterPage();
          },
        ));
      });
    }


    /**
     * 找回密码
     */
    void _findPassWord(){
//      setState(() {
//        Navigator.of(context).push(new MaterialPageRoute<Null>(
//          builder: (BuildContext context) {
//            return new TabAcccountsPage();
//          },
//        ));
//      });
    }
    // DefaultTextStyle.merge允许您创建一个默认文本，由子控件和所有后续子控件继承的风格
    var reigistFindpass = DefaultTextStyle.merge(
        child: new Container(
            padding: new EdgeInsets.all(0.0),
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Column(
                      children: [
                        new Container(
                          padding: new EdgeInsets.all(5.0),
                          child: new FlatButton(
                            onPressed: _signUpAction,
                            child: new Text("免费注册"
                              ,
                              style: descTextStyle,),

                          ),

                        ),

                      ]
                  ),
                  new Column(
                      children: [
                        new Container(
                          width: 0.4,
                          height: 20.0,
                          decoration: new BoxDecoration(
                            color: const Color(0xFF999999),
                          ),
                        ),

                      ]
                  ),
                  new Column(
                      children: [
                        new Container(
                          padding: new EdgeInsets.all(5.0),
                          child: new FlatButton(
                            onPressed: _findPassWord,
                            child: new Text("忘记密码"
                              ,
                              style: descTextStyle,),

                          ),

                        ),

                      ]
                  ),
                ]
            )
        )
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
            textTile,
            phoneInputWidget,
            _loginType?passwordInputWidget: codeWidget,
            btnLoginWidget,
            fasterLoginWidget,
            reigistFindpass,
            agreementWidget
          ],
        ),
      ),
    );

    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          bgWidget,
          new ListView(
            children: <Widget>[
              logoWidget,
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

  Widget logoWidget=new Container(
    margin: const EdgeInsets.only( top: 50.0,bottom: 50.0),
    child:
    new Center(
        child: new Image.asset(
          'static/images/logo_icon.png',
          width: 40.0,
          height: 40.0,
        )),
  );

  Widget textTile = new Container(
      margin: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: new Center(
        child: new Text(
          '账号密码登录',
          style: new TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      )
  );


}
