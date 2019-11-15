import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';//导入网络请求相关的包
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ydcflutter_app/widget/dialog/YDCBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:ydcflutter_app/widget/dialog/YDCLoadingDialog.dart';
import 'package:ydcflutter_app/utils/YDCCommonUtils.dart';
import 'package:ydcflutter_app/widget/dialog/YDCMessageDialog.dart';
import 'package:ydcflutter_app/widget/dialog/YDCCustomSureDialog.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    // 方式一：默认设置宽度1080px，高度1920px
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    // 方式二：设置宽度750px，高度1334px
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    // 方式三：设置宽度750px，高度1334px，根据系统字体进行缩放
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
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
                      //takephotosDialogWidget(context);
                      showDialog(
                          barrierDismissible: true,//是否点击空白区域关闭对话框,默认为true，可以关闭
                          context: context,
                          builder: (BuildContext context) {
                            var list = List();
                            list.add('拍照');
                            list.add('从手机相册选择');
                            for(var i=3;i<8;i++){
                              list.add('菜单'+i.toString());
                            }
                            return YDCBottomSheet(
                              list: list,
                              onItemClickListener: (index) async {

                                Fluttertoast.showToast(
                                    msg: list[index],
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)
                                );
                                    Navigator.pop(context);

                              },
                            );
                          });
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[

                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("弹出底部选择对话框",
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
                                child: new Text("弹出分享对话框",
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
                      showCupertinoAlertDialog(context);
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[

                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("弹出消息对话框",
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
                      showDialog<Null>(
                          context: context,
                          barrierDismissible: false,//点击遮罩不关闭对话框,对于自定义Dialog没起作用，需要在内部自己处理
                          builder: (context) {
                            //StatefulBuilder 来构建 dialog
                            //使用参数 state来更新 dialog 中的数据内容
                            return new CustomSureDialog(
                              message: "我是中国人",
                              sureEvent: () {
                                print("确认 关闭");
                                Navigator.pop(context);
                              },
                              onCloseEvent: () {
                                print("取消 关闭");
                                Navigator.pop(context);
                              },
                              //通过state来刷新内容
                            );

                          });

                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("弹出第二种消息提示对话框",
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
                      showDialog<Null>(
                          context: context,
                          barrierDismissible: false,//点击遮罩不关闭对话框
                          builder: (context) {
                            //StatefulBuilder 来构建 dialog
                            //使用参数 state来更新 dialog 中的数据内容
                            return new YDCMessageDialog(
                              title: "我是title",
                              message: "我是中国人我是中国人我是中国人我是中国人我是中国人我是中国人我是中国人我是中国人我是中国人我是中国人",
                              onPositivePressEvent: () {
                                print("确认 关闭");
                                Navigator.pop(context);
                              },
                              onCloseEvent: () {
                                print("取消 关闭");
                                Navigator.pop(context);
                              },
                              //通过state来刷新内容
                            );

                          });

                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("弹出第三种消息提示对话框",
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
                      showInputCupertinoAlertDialog(context);
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[

                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("弹出输入对话框",
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

                      List<String> list = [
                        "666",
                        "666",
                        "666",
                        "666",
                        "666",
                        "666",
                        "666",
                        "666",
                        "666",
                        "666",
                      ];
                      YDCCommonUtils.showCommitOptionDialog(context, list, (index) {
                      }, height: 400.0);
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[

                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("弹出选择对话框",
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
                      showLoadingDialog(context);
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("弹出Loading对话框",
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
                      YDCCommonUtils.showLoadingDialog(context);
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("弹出Loading第二种对话框",
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
                      YDCCommonUtils.showAlertDialog(context, "Bug修复");
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("弹出升级对话框",
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

                      showtest(context);

                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("TEST",
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

  showCupertinoAlertDialog(context) {
    showDialog(context: context,
        builder: (BuildContext context) {
         return CupertinoAlertDialog(
            title: Text('我是标题'),
            content:Text('我是content'),
            actions:<Widget>[
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: (){
                  print('yes...');
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: (){
                  print('no...');
                  Navigator.of(context).pop();
                },
              ),
            ],
          );

    });

  }


  showInputCupertinoAlertDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('温馨提示'),
            content: Card(
              elevation: 0.0,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        hintText: '请输入内容',
                        filled: true,
                        fillColor: Colors.grey.shade50),
                        onChanged: (String value){
                    },
                  ),

                ],
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('确定'),
              ),
            ],
          );
        });


  }

  showLoadingDialog(context) {
    showDialog<Null>(
      context: context, //BuildContext对象
      barrierDismissible: true,
      builder: (BuildContext context) {
        return new YDCLoadingDialog( //调用对话框
          text: '正在处理中...',
        );
      });
  }


  showtest(context){


  }

  @override
  void dispose() {
    super.dispose();

  }

}