import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';//导入网络请求相关的包
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ydcflutter_app/main/MainPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String mPhoneText;

  bool _correctPhone = true;
  bool _correctPassword = true;
  bool _passLogin=true;
  String _verifyCode = '';

  int _seconds = 0;
  String _verifyStr = '获取验证码';
  String _loginTypeChangeStr='手机快捷登录';
  Timer _timer;


//  PromptPage promptPage = new PromptPage();


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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Widget edtPhone = new Container(
      margin: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      width: MediaQuery
          .of(context)
          .size
          .width * 0.85,
      child:
      new TextField(
          controller: _phoneController,
          maxLines: 1,
          onChanged: (text){
            if(text.length<=11){
              mPhoneText=text;
            }else{
              _phoneController.text=mPhoneText.toString();
              _passwordController.selection=new TextSelection.fromPosition(
                  new TextPosition(offset: 11,affinity: TextAffinity.downstream)
              );
            }
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

    Widget edtPassword = new Container(
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
        onSubmitted: (value) {
          _checkInput();
        },
      ),
    );




    Widget verifyCodeEdit=new Padding(
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
        onSubmitted: (value){
//        checkInput();
        },
      ),
    );


    Widget verifyCodeBtn = new InkWell(
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
          style: new TextStyle(fontSize: 14.0,color: const Color(0xFF4B85FA) ),
        ),
      ),
    );

    Widget _edtPhoneCode(){
      return new Padding(
        padding: new EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 0.0),
        child: new Stack(
          children: <Widget>[
            verifyCodeEdit,
            new Align(
              alignment: Alignment.topRight,
              child: verifyCodeBtn,
            ),
          ],
        ),
      );
    }


    void _loginAction(){
      //print("点击了按钮22");

      setState(() {
        Fluttertoast.showToast(
            msg: "登录成功！",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

        );
        Navigator.of(context).push(new MaterialPageRoute<Null>(
          builder: (BuildContext context) {
//                return new HomePage();
            return new MainPage();
          },
        ));
      });



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
                "登 录",
                textScaleFactor: 1.1,
                style: new TextStyle(fontSize: 16.0, color: Colors.white),
              )),
        ));



    Widget changeLoginText =
    new Container(
      padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: new FlatButton(
          onPressed: null,
          child: new Text('$_loginTypeChangeStr',
              style: new TextStyle(fontSize: 14.0,
                color: const Color(0xff4B85FA),
              )
          )),
    );


    TextStyle descTextStyle = new TextStyle(
      color: const Color(0xFF999999),
      fontSize: 12.0,
    );

    void _openSignUp() {
//      setState(() {
//        Navigator.of(context).push(new MaterialPageRoute<Null>(
//          builder: (BuildContext context) {
//            return new SignUp();
//          },
//        ));
//      });
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
                            onPressed: _openSignUp,
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


    /**
     * 用户协议
     */
    bool isChecked = true;
    Widget agreement = new Container(
      padding: new EdgeInsets.all(0.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            //padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: new Checkbox(value: isChecked,
              onChanged: (bool) {
                setState(() {
                  isChecked = !bool;
                });
              },
              activeColor: const Color(0xff4B85FA),
            ),
          ),
          new Container(
            child: new Text("  阅读并同意xxxx",
              style: descTextStyle,),
          ),
          new Container(
            child: new Text("《用户协议》",
              style: new TextStyle(
                color: const Color(0xff4B85FA),
                fontSize: 12.0,
              ),),
          )
        ],
      ),
    );
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
            textTile,
            edtPhone,
            _passLogin==true? edtPassword: _edtPhoneCode(),
            buttonLogin,
            changeLoginText,
            reigistFindpass,
            agreement
          ],
        ),
      ),
    );

    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          background,
          new ListView(
            children: <Widget>[
              pangmaologo,
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

  Widget background = new Opacity(

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

  Widget pangmaologo =new Container(
    margin: const EdgeInsets.only( top: 50.0,bottom: 50.0),
    child:
    new Center(
        child: new Image.asset(
          'images/logo_pm.png',
          width: 107.0,
          height: 20.0,
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

class ShowAwait extends StatefulWidget {
  ShowAwait(this.requestCallback);
  final Future<int> requestCallback;

  @override
  _ShowAwaitState createState() => new _ShowAwaitState();
}

class _ShowAwaitState extends State<ShowAwait> {
  @override
  initState() {
    super.initState();
    new Timer(new Duration(seconds: 1), () {
      widget.requestCallback.then((int onValue) {
        Navigator.of(context).pop(onValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }
}