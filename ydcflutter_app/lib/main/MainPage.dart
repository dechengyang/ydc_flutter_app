import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';//导入网络请求相关的包
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ydcflutter_app/home/HomePage.dart';
import 'package:ydcflutter_app/category/CategoryPage.dart';
import 'package:ydcflutter_app/shopping/ShoppingcartPage.dart';
import 'package:ydcflutter_app/me/MyPage.dart';
import 'package:ydcflutter_app/widget/ydc_tab_icon.dart';


const double _kTabTextSize = 11.0;
const int INDEX_GRAB = 0;
const int INDEX_ORDER = 1;
const int INDEX_ACCOUNTS = 2;
const int INDEX_CARS = 3;
Color _kPrimaryColor = const Color(0xFFe9546b);
Color _kTabDefaultColor=const Color(0xFF333333);
class MainPage extends StatefulWidget {
  @override
  State createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{

  int _currentIndex = 0;
  TabController _controller;
  VoidCallback onChanged;

  @override
  void initState() {
    super.initState();
    _controller =
    new TabController(initialIndex: _currentIndex, length: 4, vsync: this);
    onChanged = () {
      setState(() {
        _currentIndex = this._controller.index;
      });
    };

    _controller.addListener(onChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(onChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new TabBarView(
        children: <Widget>[
          new HomePage(),
          new CategoryPage(),
          new ShoppingcartPage(),
          new MyPage()
        ],
        controller: _controller,
      ),
      bottomNavigationBar: new Material(
        color: Colors.white,
        child: new TabBar(
          controller: _controller,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.white,
          labelStyle: new TextStyle(fontSize: _kTabTextSize),
          tabs: <TabIcon>[
            new TabIcon(
                icon: _currentIndex == INDEX_GRAB
                    ? "static/images/home_selected_icon.png"
                    : "static/images/home_normal_icon.png",
                text: "首页",
                color: _currentIndex == INDEX_GRAB ? _kPrimaryColor : _kTabDefaultColor
            ),
            new TabIcon(
                icon: _currentIndex == INDEX_ORDER
                    ? "static/images/category_selected_icon.png"
                    : "static/images/category_normal_icon.png",
                text: "分类",
                color: _currentIndex == INDEX_ORDER ? _kPrimaryColor : _kTabDefaultColor
            ),
            new TabIcon(
                icon: _currentIndex == INDEX_ACCOUNTS
                    ? "static/images/shoppingcart_selected_icon.png"
                    : "static/images/shoppingcart_normal_icon.png",
                text: "购物车",
                color: _currentIndex == INDEX_ACCOUNTS ? _kPrimaryColor : _kTabDefaultColor
            ),
            new TabIcon(
                icon: _currentIndex == INDEX_CARS
                    ? "static/images/my_selected_icon.png"
                    : "static/images/my_normal_icon.png",
                text: "我的",
                color: (_currentIndex == INDEX_CARS) ? _kPrimaryColor : _kTabDefaultColor
            ),
          ],
        ),
      ),
    );
  }
}