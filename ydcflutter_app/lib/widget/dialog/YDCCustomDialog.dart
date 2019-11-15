import 'package:flutter/material.dart';

/**
 * 自定义Dialog
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class YDCCustomDialog extends Dialog {
  //子布局
  Widget childWidget;
  //左侧按钮显示文案
  String negativeText;
  //右侧按钮显示文案
  String positiveText;
  //标题显示文案
  String title;
  //显示标题下的分隔线
  bool isShowTitleDivi;
  //显示底部确认按钮上的分隔线
  bool isShowBottomDivi;
  //左侧按钮点击事件（取消）
  Function onCloseEvent;
  //右侧按钮点击事件（确认）
  Function onPositivePressEvent;

  //标题默认高度
  double defaultTitleHeight = 40.0;

  YDCCustomDialog({
    Key key,
    @required this.childWidget,
    @required this.title = "提示",
    this.negativeText,
    this.positiveText,
    this.onPositivePressEvent,
    this.isShowTitleDivi=true,
    this.isShowBottomDivi=true,
    @required this.onCloseEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Material(
        type: MaterialType.transparency,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //白色背景
            new Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              margin: const EdgeInsets.all(12.0),
              child: new Column(
                children: <Widget>[
                  //标题
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: defaultTitleHeight,
                      child: Center(
                        child: new Text(
                          title,
                          style: new TextStyle(
                              fontSize: 16.0, color: Color(0xff666666)),
                        ),
                      ),
                    ),
                  ),
                  //标题下的分隔线
                  new Container(
                    color: isShowTitleDivi?Color(0xffe0e0e0):Color(0xffffffff),
                    margin: EdgeInsets.only(bottom: 10.0),
                    height: 1.0,
                  ),
                  //中间显示的Widget
                  new Container(
                    constraints: BoxConstraints(minHeight: 80.0),
                    child: new Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: childWidget,
                    ),
                  ),
                  //底部的分隔线
                  new Container(
                    color: isShowBottomDivi?Color(0xffe0e0e0):Colors.white,
                    margin: EdgeInsets.only(top: 10.0),
                    height: 1.0,
                  ),
                  //底部的确认取消按钮
                  this._buildBottomButtonGroup(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonGroup() {
    var widgets = <Widget>[];
    if (negativeText != null && negativeText.isNotEmpty)
      widgets.add(_buildBottomCancelButton());
    if (positiveText != null && positiveText.isNotEmpty)
      widgets.add(_buildBottomPositiveButton());
    return Container(
      height: 54.0,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: widgets,
      ),
    );
  }

  Widget _buildBottomCancelButton() {
    return new FlatButton(
      onPressed: onCloseEvent,
      child: new Text(
        negativeText,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildBottomPositiveButton() {
    return new FlatButton(
      onPressed: onPositivePressEvent,
      child: new Text(
        positiveText,
        style: TextStyle(
          color: Colors.red,
          fontSize: 16.0,
        ),
      ),
    );
  }
}

