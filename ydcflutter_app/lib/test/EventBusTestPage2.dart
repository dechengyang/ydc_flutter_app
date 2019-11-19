import 'package:flutter/material.dart';
import 'package:ydcflutter_app/common/test/CartModel.dart';
import 'package:ydcflutter_app/common/test/Item.dart';
import 'package:provider/provider.dart';
import 'package:ydcflutter_app/eventbus/YDCEventBusManage.dart';
import 'package:ydcflutter_app/eventbus/EventParam.dart';
import 'package:ydcflutter_app/test/EventBusTestPage1.dart';


class EventBusTestPage2 extends StatefulWidget {
  @override
  State createState() => new _EventBusTestPage2State();
}

class _EventBusTestPage2State extends State<EventBusTestPage2> {

  BuildContext mContext;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onFire() {
    //bus.emit("login",new EventParam("1",'把无用同志发配到前一个页面'));
    eventBus.fire(EventParam("110",'把无用同志发配到前一个页面'));
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold( body:Center(

      child: Builder(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Builder(builder: (context) {
              print("RaisedButton build"); //在后面优化部分会用到
              return RaisedButton(
                child: Text("使用EventBus更新上一个页面的数据"),
                onPressed: () {
                  _onFire();
                  Navigator.of(context).pop();

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
  }
}

