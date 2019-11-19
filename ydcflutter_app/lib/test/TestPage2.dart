import 'package:flutter/material.dart';
import 'package:ydcflutter_app/common/test/CartModel.dart';
import 'package:ydcflutter_app/common/test/Item.dart';
import 'package:provider/provider.dart';

class TestPage2 extends StatefulWidget {
  @override
  State createState() => new _TestPage2State();
}

class _TestPage2State extends State<TestPage2> {

  BuildContext mContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:Center(
        child: Builder(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Builder(builder: (context) {
                var cart = Provider.of<CartModel>(context);
                return Text("商品名称: ${cart.name}");
              }),
              Builder(builder: (context) {
                var cart = Provider.of<CartModel>(context);
                return Text("总价: ${cart.totalPrice}");
              }),
              Builder(builder: (context) {
                return RaisedButton(
                  child: Text("添加商品"),
                  onPressed: () {
                    //给购物车中添加商品，添加后总价会更新
                    Provider.of<CartModel>(context).add(Item(10.0, 1));
                  },
                );
              }),
              Builder(builder: (context) {
                return RaisedButton(
                  child: Text("修改商品名称"),
                  onPressed: () {
                    //使用Provider修改商品名称
                    Provider.of<CartModel>(context).setName("无用牌毛巾");
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

