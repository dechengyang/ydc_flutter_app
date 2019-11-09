import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:ydcflutter_app/common/api.dart';
import 'package:ydcflutter_app/category/bean/navi_entity.dart';
import 'package:ydcflutter_app/res/ydc_colors.dart';

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
                index == i ? Theme.of(context).primaryColor : Colors.white),
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

  Widget getChip(int i) {
    //更新对应下标数据
    _updateArticles(i);
    return Wrap(
      spacing: 10.0, //两个widget之间横向的间隔
      direction: Axis.horizontal, //方向
      alignment: WrapAlignment.start, //内容排序方式
      children: List<Widget>.generate(
        articles.length,
            (int index) {
          return ActionChip(
            //标签文字
            label: Text(
              articles[index].title,
              style: TextStyle(fontSize: 16, color: YDColors.color_666),
            ),
            //点击事件
            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => ArticleDetail(
//                      title: articles[index].title, url: articles[index].link),
//                ),
//              );
            },
            elevation: 3,
            backgroundColor: Colors.grey.shade200,
          );
        },
      ).toList(),
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