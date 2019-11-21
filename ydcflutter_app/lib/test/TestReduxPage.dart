import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ydcflutter_app/redux/user_redux.dart';
import 'package:ydcflutter_app/me/bean/User.dart';
import 'package:ydcflutter_app/test/bean/YDCState.dart';


class TestReduxPage extends StatefulWidget {
  @override
  State createState() => new _TestReduxPageState();
}

class _TestReduxPageState extends State<TestReduxPage> {

  BuildContext mContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //使用 StoreBuilder 获取 store 中的state数据
    return  new StoreBuilder<YDCState>(
            builder: (context, store) {
              return new Scaffold(
                  body: Center(
                      child: Builder(builder: (context) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Builder(builder: (context) {
                                return Text("使用Redux更新数据: ${store.state.user.name??"---"}");
                              }),
                              new Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child:
                                  new FloatingActionButton(
                                    onPressed: (){
                                      var newUserInfo=User("把用户名字更新为无用");
                                      store.dispatch(new UpdateUserAction(newUserInfo));
                                    },
                                    child: Icon(Icons.add),
                                  )
                              )
                            ]
                        );

                      }))
              );
            });
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

