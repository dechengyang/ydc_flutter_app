import 'package:flutter/material.dart';

/**
 * 自定义LoadingDialog
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class YDCLoadingDialog extends Dialog {
  BuildContext mContext;
  String text;
  YDCLoadingDialog({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    mContext=context;
    return new Material( //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center( //保证控件居中效果
        child: new SizedBox(
          width: 120.0,
          height: 120.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: new Text(
                    text,
                    style: new TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  ///关闭loading
  void close() {
    Navigator.of(mContext).pop();
  }
}