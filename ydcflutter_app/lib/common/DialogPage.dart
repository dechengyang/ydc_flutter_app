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
import 'package:ydcflutter_app/widget/dialog/YDCCustomDialog.dart';

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

                      showEvaluateDialog();

                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("弹出服务评价对话框",
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

  //是否满意标识位记录
  int pariseSelectIndex = 0;
  //不满意原因标识位记录
  int pariseSelectIndex2 = 0;
  //在按钮点击的时候直接调用
  void showEvaluateDialog() {
    showDialog<Null>(
        context: context,
        //点击背景不消失
        barrierDismissible: true,
        builder: (context) {
          //StatefulBuilder 来构建 dialog
          //使用参数 state来更新 dialog 中的数据内容
          return StatefulBuilder(builder: (context, state) {
            //创建dialog
            return new YDCCustomDialog(
              title: "商品服务评价",
              negativeText: "取消",
              positiveText: "确认",
              isShowTitleDivi: false,
              onPositivePressEvent: () {
                print("确认 关闭");
                Navigator.pop(context);
              },
              onCloseEvent: () {
                print("取消 关闭");
                Navigator.pop(context);
              },
              //通过state来刷新内容
              childWidget: buildPariseChildDialog(state),
            );
          });
        });
  }

  Widget buildPariseChildDialog(state){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          //填充
          mainAxisSize: MainAxisSize.max,
          //平分空白
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildPariseChildWidget(
                0, "非常满意", pariseSelectIndex == 0 ? true : false,state),
            buildPariseChildWidget(
                1, "满意", pariseSelectIndex == 1 ? true : false,state),
            buildPariseChildWidget(
                2, "不满意", pariseSelectIndex == 2 ? true : false,state),
          ],
        ),
        pariseSelectIndex==2?gridViewDefaultCount(state):Container(),
      ],
    );
  }

  Widget buildPariseChildWidget(int index, String message, bool select,state) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        //设置 child 居中
        alignment: Alignment(0, 0),
        height: 30,
        child: new Center(
          child: new Material(
            child: new Ink(
              key: ValueKey(index),
              //设置背景
              decoration: new BoxDecoration(
                //背景
                color: Colors.white,
                //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                //设置四周边框
                border: new Border.all(
                    width: 1, color: select ? Colors.red : Colors.grey),
              ),
              child: new InkResponse(
                borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
                //点击或者toch控件高亮时显示的控件在控件上层,水波纹下层
                highlightColor: Color(0xfffbfbfb),
                //点击或者toch控件高亮的shape形状
                highlightShape: BoxShape.rectangle,
                //.InkResponse内部的radius这个需要注意的是，我们需要半径大于控件的宽，如果radius过小，显示的水波纹就是一个很小的圆，
                //水波纹的半径
                radius: 0.0,
                //水波纹的颜色 设置了highlightColor属性后 splashColor将不起效果
                splashColor: Color(0xfffbfbfb),
                //true表示要剪裁水波纹响应的界面   false不剪裁  如果控件是圆角不剪裁的话水波纹是矩形
                containedInkWell: true,

                onTap: () {
                  pariseSelectIndex = index;
                  print('click ' + pariseSelectIndex.toString());
                  state(() {});
                },
                child: new Container(
                  //不能在InkResponse的child容器内部设置装饰器颜色，否则会遮盖住水波纹颜色的，containedInkWell设置为false就能看到是否是遮盖了。
                  width: 300.0,
                  height: 50.0,
                  //设置child 居中
                  alignment: Alignment(0, 0),
                  child: Text(
                    message,
                    style: TextStyle(
                        color: select ? Colors.red : Colors.grey,
                        fontSize: 14.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget gridViewDefaultCount(state) {
    int count = 3;
    double height = 60;

    return Container(
      margin: EdgeInsets.only(top: 20),
      //设置 child 居中
      alignment: Alignment(0, 0),
      height: height,
      //边框设置
      decoration: new BoxDecoration(
        //背景
        color: Color(0xfff6f6f6),
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        //设置四周边框
        border: new Border.all(width: 1, color: Color(0xfff6f6f6)),
      ),
      child: initListWidget(count,state),
    );
  }

  Widget initListWidget(int count,state) {
    List<Widget> lists = [];
    List<Widget> clists = [];

    lists.add(buildPariseSelectChildWidget(
        0, "送货慢", pariseSelectIndex2 == 0 ? true : false,state));
    lists.add(buildPariseSelectChildWidget(
        1, "服务差", pariseSelectIndex2 == 1 ? true : false,state));
    lists.add(buildPariseSelectChildWidget(
        2, "次品", pariseSelectIndex2 == 2 ? true : false,state));
    clists.add(Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: lists,
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: clists,
    );
  }

  Widget buildPariseSelectChildWidget(int index, String message, bool select,state) {
    return InkWell(
      //单击事件响应
      onTap: () {

        pariseSelectIndex2 = index;
        state(() {});
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            select
                ? "static/images/check.png"
                : "static/images/uncheck.png",
            width: 20.0,
            height: 20.0,
          ),
          Padding(
            child: Text(
              message,
              style: TextStyle(fontSize: 13, color: Color(0xff666666)),
            ),
            padding: EdgeInsets.only(left: 5.0),
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