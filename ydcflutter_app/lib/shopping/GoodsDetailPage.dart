import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';//导入网络请求相关的包
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:ydcflutter_app/utils/YDCLoading.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ydcflutter_app/widget/YDCButton.dart';

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class _Page {
  _Page({this.label});

  final String label;

  String get id => label[0];

  @override
  String toString() => '$runtimeType("$label")';
}

class _CardData {
  const _CardData({this.title, this.imageAsset, this.imageAssetPackage});

  final String title;
  final String imageAsset;
  final String imageAssetPackage;
}

final Map<_Page, List<_CardData>> _allPages = <_Page, List<_CardData>>{
  new _Page(label: '商品'): <_CardData>[
    const _CardData(
      title: 'Vintage Bluetooth Radio',
      imageAsset: 'shrine/products/radio.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Sunglasses',
      imageAsset: 'shrine/products/sunnies.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Clock',
      imageAsset: 'shrine/products/clock.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Red popsicle',
      imageAsset: 'shrine/products/popsicle.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Folding Chair',
      imageAsset: 'shrine/products/lawn_chair.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Green comfort chair',
      imageAsset: 'shrine/products/chair.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Old Binoculars',
      imageAsset: 'shrine/products/binoculars.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Teapot',
      imageAsset: 'shrine/products/teapot.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Blue suede shoes',
      imageAsset: 'shrine/products/chucks.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
  ],
  new _Page(label: '详情'): <_CardData>[
    const _CardData(
      title: 'Beachball',
      imageAsset: 'shrine/products/beachball.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Dipped Brush',
      imageAsset: 'shrine/products/brush.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Perfect Goldfish Bowl',
      imageAsset: 'shrine/products/fish_bowl.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
  ],

  new _Page(label: '评论'): <_CardData>[
    const _CardData(
      title: 'Beachball',
      imageAsset: 'shrine/products/beachball.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Dipped Brush',
      imageAsset: 'shrine/products/brush.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Perfect Goldfish Bowl',
      imageAsset: 'shrine/products/fish_bowl.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
  ],
  new _Page(label: '推荐'): <_CardData>[
    const _CardData(
      title: 'Beachball',
      imageAsset: 'shrine/products/beachball.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Dipped Brush',
      imageAsset: 'shrine/products/brush.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Perfect Goldfish Bowl',
      imageAsset: 'shrine/products/fish_bowl.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
  ],
};

class _CardDataItem extends StatelessWidget {
  const _CardDataItem({this.page, this.data});

  static const double height = 272.0;
  final _Page page;
  final _CardData data;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Align(
              alignment:
              page.id == 'L' ? Alignment.centerLeft : Alignment.centerRight,
              child: new CircleAvatar(child: new Text('${page.id}')),
            ),
            new SizedBox(
              width: 144.0,
              height: 144.0,
              child: new Image.asset(
                data.imageAsset,
                package: data.imageAssetPackage,
                fit: BoxFit.contain,
              ),
            ),
            new Center(
              child: new Text(
                data.title,
                style: Theme
                    .of(context)
                    .textTheme
                    .title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoodsDetailPage extends StatefulWidget {
  @override
  State createState() => new _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String mPhoneText;
  List<String>   bannerDatas=List();

  SwiperController _swiperController;

  String data;
  void _getDio() async {
//    YDCLoadingPage loadingPage = YDCLoadingPage(context);
//    loadingPage.show();
    Response response =
    await Dio().get("https://www.runoob.com/try/ajax/json_demo.json");
    print("get ====== "+response.toString());
    final body = json.decode(response.toString());

    setState(() {
      data = body['name'];
      print("title ====== "+data);

      bannerDatas = [
        'https://img.alicdn.com/tps/TB1oHwXMVXXXXXnXVXXXXXXXXXX-570-400.jpg',
        'https://img.alicdn.com/tps/TB1XF.gJpXXXXaUXVXXXXXXXXXX-570-400.jpg',
        'https://img.alicdn.com/tps/i4/TB1VGZBJXXXXXX3aXXXCtjtIVXX-570-400.jpg',
        'https://aecpm.alicdn.com/simba/img/TB1t9gUXXXXXXczaVXXSutbFXXX.jpg',
      ];
      print("bannerDatas ====== "+bannerDatas.toString());

    });

    _swiperController.startAutoplay();
    //loadingPage.close();
  }

  void _postDio() async {
//    YDCLoadingPage loadingPage = YDCLoadingPage(context);
//    loadingPage.show();
    var headers = Map<String, String>();
    headers['loginSource'] = 'Android';
    headers['useVersion'] = '3.1.0';
    headers['isEncoded'] = '1';
    headers['bundleId'] = 'com.nongfadai.iospro';
    headers['Content-Type'] = 'application/json';

    Dio dio = Dio();
    dio.options.baseUrl = "http://api.juheapi.com/japi/toh";
    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;
    dio.options.headers.addAll(headers);
    dio.options.method = 'post';

    var params = {
      'v': '1.0',
      'month': '7',
      'day': '25',
      'key': 'bd6e35a2691ae5bb8425c8631e475c2a'
    };

    Options option = Options(method: 'post');
    Response response = await dio.post("http://api.juheapi.com/japi/toh",
        /*data: {
          "v": "1.0",
          "month": "7",
          "day": "25",
          "key": "bd6e35a2691ae5bb8425c8631e475c2a"
        },*/
        data: params,
        options: option);

    if (response.statusCode == 200) {
      debugPrint('===请求求url: ${response.request.uri.toString()}');
      debugPrint('===请求headler: ${response.request.headers}');
      debugPrint('===请求结果: \n${response.data}\n');
      //loadingPage.close();
    } else {
      print('请求失败');
      //loadingPage.close();
    }


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _swiperController = SwiperController();
    _getDio();
    // _postDio();

  }

  @override
  Widget build(BuildContext context) {

    // 建议在第一次 build 的时候就进行初始化，这样接下来就可以放心使用了。

    // 方式一：默认设置宽度1080px，高度1920px
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    // 方式二：设置宽度750px，高度1334px
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    // 方式三：设置宽度750px，高度1334px，根据系统字体进行缩放
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);



    return new DefaultTabController(
      length: _allPages.length,
      child: new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverOverlapAbsorber(
                handle:
                NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: new SliverAppBar(
                  pinned: true,
                  expandedHeight: 380.0,
                  // 这个高度必须比flexibleSpace高度大
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                      child: new Container(
                        child: new TabBar(
                          indicatorColor: Colors.white,//选中下划线颜色,如果使用了indicator这里设置无效
                          labelColor: Colors.white,
                          //unselectedLabelColor: Colors.black,
                          labelStyle: TextStyle(fontSize: 16),
                          unselectedLabelStyle:TextStyle(fontSize: 14) ,
                          indicatorWeight: 3,
                          tabs: _allPages.keys
                              .map(
                                (_Page page) => new Tab(
                              child: new Tab(text: page.label),
                            ),
                          )
                              .toList(),
                        ),
                        color: Colors.redAccent[100],
                      ),
                      preferredSize: new Size(double.infinity, 46.0)),
                  // 46.0为TabBar的高度，也就是tabs.dart中的_kTabHeight值，因为flutter不支持反射所以暂时没法通过代码获取
                  actions: <Widget>[
                      new IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "正在建设中...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                        );
                      },
                      ),
                    new IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "正在建设中...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                        );
                      },
                    ),
                  ],
                  flexibleSpace: new Container(
                    child: new Column(
                      children: <Widget>[
                        new AppBar(
                          title: Text("商品详情"),
                        ),
                        new Container(
                            width: MediaQuery.of(context).size.width,
                            height: 180.0,
                            margin: EdgeInsets.only(bottom: 10.0),
                            child:
                            new Swiper(
                              itemBuilder: (BuildContext context,int index){
                                return new Image.network(bannerDatas[index],fit: BoxFit.fill,);
                              },
                              itemCount: bannerDatas.length,
                              //触发时是否停止播放
                              autoplayDisableOnInteraction: true,
                              //pagination: new SwiperPagination(),
                              //默认指示器
                              pagination: SwiperPagination(
                                // SwiperPagination.fraction 数字1/5，默认点
                                builder: DotSwiperPaginationBuilder(size: 8, activeSize: 12,activeColor:Color(0xFFe9546b)),
                              ),
                              //默认分页按钮
//        control: SwiperControl(),
                              controller: _swiperController,
                              //autoplay: true,
                              onTap: (index) => Fluttertoast.showToast(
                                  msg: "点击了第$index个",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                              ),
                            )),
                        new Container(
                            width: MediaQuery.of(context).size.width,
                            height:200.0,
                            decoration:  new BoxDecoration(
                              color: Colors.white,
                            ),
                            child: new Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: <Widget>[
                                new Padding(
                                    padding: const EdgeInsets.only(left: 10.0,top: 0.0),
                                    child: new Text("￥200.00",
                                      style: new TextStyle(fontSize: 16.0,
                                          color:const Color(0xFFe9546b)),)),
                                new Padding(
                                    padding: const EdgeInsets.only(left: 10.0,top: 0.0),
                                    child: new Text("￥320.00",
                                      style: new TextStyle(fontSize: 12.0,
                                          color:const Color(0xFFaaaaaa)),)),

                                new Padding(
                                    padding: const EdgeInsets.only(left: 12.0,top: 0.0),
                                    child: new Text("正品芦荟胶祛痘睡眠美白面膜泥粉免洗女男补水保湿面霜春季护肤品",
                                      style: new TextStyle(fontSize: 16.0,
                                          color:const Color(0xFF333333)),)),

                              ],)

                        )

                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body:new Stack(
              children: <Widget>[
                new TabBarView(
                children: _allPages.keys.map((_Page page) {
              //SafeArea 适配刘海屏的一个widget
                return new SafeArea(
                top: false,
                bottom: false,
                child: new Builder(
                  builder: (BuildContext context) {
                    return new CustomScrollView(
                      key: new PageStorageKey<_Page>(page),
                      slivers: <Widget>[
                        new SliverOverlapInjector(
                          handle: NestedScrollView
                              .sliverOverlapAbsorberHandleFor(context),
                        ),
                        new SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          sliver: new SliverFixedExtentList(
                            itemExtent: _CardDataItem.height,
                            delegate: new SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                final _CardData data = _allPages[page][index];
                                return new Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: new _CardDataItem(
                                    page: page,
                                    data: data,
                                  ),
                                );
                              },
                              childCount: _allPages[page].length,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ), Positioned(
                  width: ScreenUtil().setWidth(750),
                  height: ScreenUtil().setHeight(110),
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Color(0xFFe5e5e5), width: 1)),
                        color: Colors.white),
                    child: Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                            width: 60,
                            height: ScreenUtil().setHeight(88),
                            child:
                            new InkWell(
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
                              child:Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.message,
                                    size: 15,
                                  ),
                                  Text('联系客服',  style: new TextStyle(fontSize: 12.0,
                                      color:const Color(0xFF666666)))
                                ],
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                            width: 50,
                            height: ScreenUtil().setHeight(88),
                            child:
                            new InkWell(
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
                              child:Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.store,
                                    size: 15,
                                  ),
                                  Text('店铺',  style: new TextStyle(fontSize: 12.0,
                                      color:const Color(0xFF666666)))
                                ],
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                          width: 50,
                          height: ScreenUtil().setHeight(88),
                          child:
                            new InkWell(
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
                              child:Column(
                             children: <Widget>[
                              Icon(
                                Icons.shopping_cart,
                                size: 15,
                              ),
                              Text('购物车',   style: new TextStyle(fontSize: 12.0,
                                  color:const Color(0xFF666666)))
                            ],
                          ),
                        )),
                        Expanded(
                          flex: 1,
                          child: YDCButton(
                            color: Color.fromRGBO(253, 1, 0, 0.9),
                            text: "加入购物车",
                            cb: (){
                              Fluttertoast.showToast(
                                  msg: "正在建设中...",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                              );
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: YDCButton(
                            color: Color.fromRGBO(255, 165, 0, 0.9),
                            text: "立即购买",
                            cb: (){
                              Fluttertoast.showToast(
                                  msg: "正在建设中...",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )

              ])
        ),
      ),
    );
  }

  Widget dividerWidget=new Container(
    //margin: const EdgeInsets.only( left: 10.0,right: 10.0),
      child: new Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15.0),
          child:
          new Divider(height: 1.0,indent: 0.0,color: Color(0xFFe5e5e5))
      )

  );

  @override
  void dispose() {
    _swiperController.stopAutoplay();
    _swiperController.dispose();
    super.dispose();

  }



}