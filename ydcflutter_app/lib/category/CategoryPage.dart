import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:ydcflutter_app/common/api.dart';
import 'package:ydcflutter_app/category/bean/navi_entity.dart';
import 'package:ydcflutter_app/res/ydc_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage> {
  List<NaviData> _datas = List(); //一级分类集合
  List<NaviDataArticle> articles = List(); //二级分类集合
  int index; //一级分类下标

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  void getHttp() async {
    try {
      Response response =
      await Dio().get(Api.BASE_URL+Api.NAVI);
      //var response =await Dio().get(Api.NAVI);
      Map userMap = json.decode(response.toString());
      print("get ====== "+response.toString());
      var naviEntity = NaviEntity.fromJson(userMap);

      /// 初始化
      setState(() {
        print("title ====== "+naviEntity.toString());
        _datas = naviEntity.data;
        index = 0;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            color: YDColors.color_fff,
            child: ListView.builder(
              itemCount: _datas.length,
              itemBuilder: (BuildContext context, int position) {
                return getRow(position);
              },
            ),
          ),
        ),
        Expanded(
            flex: 5,
            child: ListView(
              children: <Widget>[
                AspectRatio(
                    aspectRatio: 16/9,
                    child: Image.network("https://img.alicdn.com/tps/TB18dwzKXXXXXctaXXXXXXXXXXX-380-200.png",fit: BoxFit.cover,)
                ),
                Container(
                  //height: double.infinity,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  color: YDColors.color_F9F9F9,
                  child: getChip(index), //传入一级分类下标
                ),
              ],
            )),
      ],
    );
  }

  Widget getRow(int i) {
    Color textColor = Theme.of(context).primaryColor; //字体颜色
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        //Container下的color属性会与decoration下的border属性冲突，所以要用decoration下的color属性
        decoration: BoxDecoration(
          color: index == i ? Colors.white :YDColors.color_f3f3f3,
          border: Border(
            left: BorderSide(
                width: 5,
                color:
                index == i ? YDColors.color_magenta: Colors.white),
          ),
        ),
        child: Text(
          _datas[i].name,
          style: TextStyle(
            color: index == i ? YDColors.black_3 : YDColors.color_666,
            fontWeight: index == i ? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          index = i; //记录选中的下标
          textColor = YDColors.colorPrimary;
        });
      },
    );
  }
//
//  Widget getChip(int i) {
//    //更新对应下标数据
//    _updateArticles(i);
//    return Wrap(
//      spacing: 10.0, //两个widget之间横向的间隔
//      direction: Axis.horizontal, //方向
//      alignment: WrapAlignment.start, //内容排序方式
//      children: List<Widget>.generate(
//        articles.length,
//            (int index) {
//          return ActionChip(
//            //标签文字
//            label: Text(
//              articles[index].title,
//              style: TextStyle(fontSize: 16, color: YDColors.color_666),
//            ),
//            //点击事件
//            onPressed: () {
//
//            },
//            elevation: 3,
//            backgroundColor: Colors.grey.shade200,
//          );
//        },
//      ).toList(),
//    );
//  }



  Widget getChip(int i) {
    //更新对应下标数据
    _updateArticles(i);
    return   new Container(
//        width: MediaQuery.of(context).size.width,
//        height:MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(top: 0.0),
        child:
        new GridView.builder(
            //padding: const EdgeInsets.all(10.0),
            shrinkWrap: true,
            physics: new NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemCount: articles.length,
            itemBuilder: (BuildContext context, int index) {
//                    if(index == picList.length - 1 ){
//                    _getPicList();
//                    }
              return gridViewItem(articles[index],context);
            }));
  }
  gridViewItem(item,context) {
    return new Container(
        //padding: const EdgeInsets.only(left: 0.0,top: 10.0,bottom: 20.0),
        height: 100.0,
        width: 100.0,
        decoration:  new BoxDecoration(
          borderRadius: new BorderRadius.circular(0.0),
          color: Colors.white,
        ),
        child: new InkWell(
          onTap: () {
            Fluttertoast.showToast(
                msg: "正在建设中...",
                toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.BOTTOM,
                timeInSecForIos:1
////            backgroundColor: Color(0xe74c3c),
////            textColor: Color(0xffffff)
//
            );
          },
          child: new Column(
            //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                    child:  new Image.network("https://img.alicdn.com/tps/TB1G5oxMVXXXXbFXFXXXXXXXXXX-190-200.jpg",
                        alignment: Alignment.bottomRight,
                        colorBlendMode: BlendMode.colorBurn,
                        fit: BoxFit.cover, // 填充拉伸裁剪
                        width: MediaQuery.of(context).size.width,
                        height: 80.0)),
               new Container(
                 margin: const EdgeInsets.only(left: 0.0,top: 4.0),

                    child: new Text(item.title,
                      style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
              ]

          ),


        )
    );
  }
  ///
  /// 根据一级分类下标更新二级分类集合
  ///
  List<NaviDataArticle> _updateArticles(int i) {
    setState(() {
      if (_datas.length != 0) articles = _datas[i].articles;
    });
    return articles;
  }
}