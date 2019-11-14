import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';//导入网络请求相关的包
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ydcflutter_app/widget/dialog/ydc_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:ydcflutter_app/widget/dialog/ydc_loadingdialog.dart';
import 'package:ydcflutter_app/utils/CommonUtils.dart';

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
                      CommonUtils.showCommitOptionDialog(context, list, (index) {
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
                      CommonUtils.showLoadingDialog(context);
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
                      CommonUtils.showUpdateDialog(context, "Bug修复");
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

  showLoadingDialog(context) {showDialog<Null>(
      context: context, //BuildContext对象
      barrierDismissible: true,
      builder: (BuildContext context) {
        return new YDCLoadingDialog( //调用对话框
          text: '正在处理中...',
        );
      });
  }
  @override
  void dispose() {
    super.dispose();

  }

}