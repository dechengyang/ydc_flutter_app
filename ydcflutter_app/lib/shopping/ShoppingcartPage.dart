import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ydcflutter_app/shopping/bean/ShopCartBean.dart';
import 'package:flutter_slidable/flutter_slidable.dart';//侧滑删除
import 'package:ydcflutter_app/res/ydc_colors.dart';
import 'package:ydcflutter_app/utils/ydc_loading_page.dart';
import 'package:ydcflutter_app/httpservice/ydc_httpmanager.dart';
import 'package:ydcflutter_app/datarepository/ydc_sharedpreferences.dart';
import 'package:ydcflutter_app/config/SharePreferenceKey.dart';
import 'package:ydcflutter_app/config/ApiConfig.dart';
import 'package:ydcflutter_app/config/Constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';

class ShoppingcartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ShoppingcartPageState();
}

class _ShoppingcartPageState extends State<ShoppingcartPage> {
  var mContext=null;
  List<ShopCartResult> _list = new List();
  var money = 0.00;
  var selectCount = 0;
  var listItemCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryChild();
    _getData();
  }

  bool isSelect = false;


  void _getData() async {
    String token = await SharedPreferencesHelper.get(SharePreferenceKey.TOKEN_KEY);
    if (token == null) {
      print("getToken ====== ");
      print(token);
      print("getToken2 ====== ");
    }
    YDCLoadingPage loadingPage = YDCLoadingPage(mContext);
    loadingPage.show();
    var params = {
      'appid': Constant.appId,
      'appsecret':Constant.SECRETKEY,
      'token': token
    };
    print("params ====== ");
    print(params);
    print("params2 ====== ");
    httpManager.clearAuthorization();
    var res = await httpManager.request(
        ApiConfig.BASE_URL+ApiConfig.getshoppingcart, params, null, new Options(method: "post"));
    if (res != null ) {
      if (Constant.DEBUG) {
        print("result999======"+res.data.toString());
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
                    msg: "登录成功！",
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

    }
  }
  void _categoryChild() {

    for(int j=0;j<2;j++){

      ShopCartResult cartResult=ShopCartResult();
      cartResult.storeName="Better Me韩"+(j+1).toString();
      cartResult.selected=true;
      cartResult.goodsIdStr="1";
      cartResult.couponShow=true;
      cartResult.storeId="1";
      print("title ====== "+cartResult.storeName);
      List<GoodsToBuyDtos> _gList=new List();
      for(int i=0;i<2;i++){
        GoodsToBuyDtos dtos=GoodsToBuyDtos();
        dtos.name="SK2限量版";
        dtos.selected=true;
        dtos.count="2";
        dtos.dValue="100";
        dtos.fee="200";
        dtos.goodsId="1";
        dtos.inventory="1";
        dtos.id="1";
        dtos.inventory="100";
        dtos.isGoodsNew=true;
        dtos.price="100";
        dtos.limitDesc="10";
        dtos.maxBatch="10";
        dtos.skuCfg="10";
        dtos.storeType="10";
        dtos.memo="10";
        dtos.minBatch="10";
        dtos.path="xxx";
        _gList.add(dtos);
      }

      cartResult.goodsToBuyDtos=_gList;
      _list.add(cartResult);
      print("size ====== "+cartResult.goodsToBuyDtos.length.toString());
    }

//    ApiService.getLogin("toBuy/list", "POST", null, (callBack) {
//      if (callBack != null) {
//        var categoryChildBean = ShopCartBean.fromJson(callBack);
//        if (categoryChildBean.success) {
//          _list.clear();
//          _list = categoryChildBean.result;
//          isSelect = _viewSelect();
//          _listMoneyCount();
//        }
//      }
//    }, (errorCallBack) => {});
  }

  _viewSelect() {
    var count = 0;
    for (var i = 0; i < _list.length; i++) {
      if (_list[i].selected) {
        count++;
      }
    }
    return count == _list.length;
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    mContext=context;
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false, //左边按钮
        centerTitle: true,
        title: new Text(
          "购物车($listItemCount)",
          style: new TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: Colors.red,
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
              child: Container(
                child: new ListView(
                  children: _itemView(),
                  padding: new EdgeInsets.only(bottom: 10),
                ),
                width: double.infinity,
                color: Colors.grey,
              )),
          Row(
            children: <Widget>[
              new Checkbox(
                  value: isSelect,
                  activeColor: Color.fromARGB(255, 255, 67, 78),
                  onChanged: (bool) {
                    for (var i = 0; i < _list.length; i++) {
                      _list[i].selected = !isSelect;
                      for (var j = 0; j < _list[i].goodsToBuyDtos.length; j++) {
                        _list[i].goodsToBuyDtos[j].selected = !isSelect;
                      }
                    }
                    isSelect = !isSelect;
                    _listMoneyCount();
                    setState(() {});
                  }),
              Text("全选"),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "不含运费 ",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    Text(
                      "合计:",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      "￥",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    Text(
                      "$money",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: new Text(
                        "结算($selectCount)",
                        style: TextStyle(color: Colors.white),
                      ),
                      width: 130,
                      height: 50,
                      color: Colors.red,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _itemView() {
    List<Widget> listWidget = List();
    for (var i = 0; i < _list.length; i++) {
      var item = _list[i].selected;
      listWidget.add(new Card(
        color: Colors.white,
        elevation: 0,
        margin: new EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: _itemViewChild(i, item),
        ),
      ));
    }
    return listWidget;
  }

  List<Widget> _itemViewChild(int index, bool item) {
    var row = new Row(
      children: <Widget>[
        new Checkbox(
            value: item,
            activeColor: Color.fromARGB(255, 255, 67, 78),
            onChanged: (bool) {
              _list[index].selected = !item;
              for (var j = 0; j < _list[index].goodsToBuyDtos.length; j++) {
                _list[index].goodsToBuyDtos[j].selected = !item;
              }
              isSelect = _viewSelect();
              _listMoneyCount();
              setState(() {});
            }),
        Text(null != _list[index].storeName ? _list[index].storeName : "")
      ],
    );
    List<Widget> listWidget = List();
    listWidget.clear();
    listWidget.add(row);
    listWidget.add(new Baseline(
      baseline: 1,
      baselineType: TextBaseline.alphabetic,
      child: new Container(
        color: Color(0xFFededed),
        height: 1,
        width: double.infinity,
      ),
    ));

    List<Widget> listWidgetChild = List();
    listWidgetChild.clear();
    for (var b = 0; b < _list[index].goodsToBuyDtos.length; b++) {
      var selected = _list[index].goodsToBuyDtos[b].selected;
      listWidgetChild.add(new Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: new Slidable(
            actionPane: SlidableScrollActionPane(),
            child: new Container(
              child: new Row(
                children: <Widget>[
                  new Checkbox(
                      value: selected,
                      activeColor: Color.fromARGB(255, 255, 67, 78),
                      onChanged: (bool) {
                        _list[index].goodsToBuyDtos[b].selected = !selected;
                        var count = 0;
                        _list[index].goodsToBuyDtos.forEach((fe) {
                          if (fe.selected) {
                            count++;
                          }
                        });
                        _list[index].selected =
                            count == _list[index].goodsToBuyDtos.length;
                        isSelect = _viewSelect();
                        _listMoneyCount();
                        setState(() {});
                      }),
//                  new Image.network(
//                    Api.getInstance().photo +
//                        _list[index].goodsToBuyDtos[b].path,
//                    fit: BoxFit.fill,
//                    width: 80,
//                    height: 80,
//                  ),
                  new Image.network("https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/3301496692/O1CN01f1ckxF1zIz202Zl7Z_!!0-item_pic.jpg_230x230.jpg_.webp",
                    fit: BoxFit.fill,
                    width: 80,
                    height: 80,
                  ),
                  Expanded(
                    child: new Padding(
                      padding: new EdgeInsets.only(left: 5, right: 5),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _list[index].goodsToBuyDtos[b].name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          new Expanded(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    _list[index].goodsToBuyDtos[b].skuCfg,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "￥${_list[index].goodsToBuyDtos[b].price}",
                                    style: TextStyle(color: Colors.red),
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
              height: 85,
            ),
            //delegate: new SlidableDrawerDelegate(),
            secondaryActions: <Widget>[
              new IconSlideAction(
                caption: '删除',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => {},
              ),
            ]),
      ));
    }
    listWidget.add(new Column(
      children: listWidgetChild,
    ));
    return listWidget;
  }

  //计算金额
  _listMoneyCount() {
    money = 0.00;
    selectCount = 0;
    listItemCount = 0;
    _list.forEach((f) {
      f.goodsToBuyDtos.forEach((item) {
        if (item.selected) {
          var itemMoney = double.parse(item.price) * double.parse(item.count);
          money = money + itemMoney;
          selectCount++;
        }
        listItemCount++;
      });
    });
  }
}
