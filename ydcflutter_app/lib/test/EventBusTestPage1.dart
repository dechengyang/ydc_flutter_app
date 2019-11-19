import 'package:flutter/material.dart';
import 'package:ydcflutter_app/common/test/CartModel.dart';
import 'package:ydcflutter_app/common/test/Item.dart';
import 'package:provider/provider.dart';
import 'package:ydcflutter_app/eventbus/YDCEventBusManage.dart';
import 'package:ydcflutter_app/eventbus/EventParam.dart';
import 'package:ydcflutter_app/test/EventBusTestPage2.dart';
import 'dart:async';
class EventBusTestPage extends StatefulWidget {
  @override
  State createState() => new _EventBusTestPageState();
}

class _EventBusTestPageState extends State<EventBusTestPage> {

  BuildContext mContext;

  StreamSubscription _subscription;
  var data="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听登录事件
    _subscription=eventBus.on<EventParam>().listen((EventParam data) =>
        show(data.name)
    );
    _subscription.resume();

  }

  void show(String val) {
    setState(() {
      data= val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold( body:Center(

      child: Builder(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Builder(builder: (context) {

              return Text("EventBus回传的数据: ${data}");
            }),

            Builder(builder: (context) {
              print("RaisedButton build"); //在后面优化部分会用到
              return RaisedButton(
                child: Text("跳转到第二页面"),
                onPressed: () {
                  //给购物车中添加商品，添加后总价会更新
                  //Provider.of<CartModel>(context).add(Item(10.0, 1));

                  Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return new EventBusTestPage2();
                    },
                  ));
                },
              );
            }),

          ],
        );
      }),
    ),
    );
  }


  Widget dividerWidget = new Container(
    //margin: const EdgeInsets.only( left: 10.0,right: 10.0),
      child: new Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
          child:
          new Divider(height: 1.0, indent: 0.0, color: Color(0xFFe5e5e5))
      )

  );

  @override
  void dispose() {
    super.dispose();
    //eventBus.destroy();
    //_subscription.resume();  //  开
    //_subscription.pause();    //  暂停
    _subscription.cancel();   //  取消

  }
}

