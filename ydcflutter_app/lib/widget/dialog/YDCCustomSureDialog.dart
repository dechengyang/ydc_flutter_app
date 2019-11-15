import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ydcflutter_app/res/ydc_style.dart';

/**
 * 自定义Dialog
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class CustomSureDialog extends Dialog {
  String message;
  Function onCloseEvent;
  Function sureEvent;

  CustomSureDialog({this.message, this.onCloseEvent, this.sureEvent});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency,//设置透明的效果
        child: Center( // 让子控件显示到中间
          child: SizedBox( //比较常用的一个控件，设置具体尺寸
            width: ScreenUtil().setWidth(600),
            height: ScreenUtil().setHeight(400),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 61),
                    child: Text(
                      message,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(36),
                          color: YDCColors.primaryValue),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 13),
                    padding: EdgeInsets.only(left: 6, right: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: onCloseEvent,
                          padding: EdgeInsets.only(
                              left: 49, top: 14, right: 49, bottom: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            '取消',
                            style: TextStyle(
                              color:YDCColors.primaryValue,
                              fontSize: ScreenUtil().setSp(36),
                            ),
                          ),
                          borderSide:
                          BorderSide(color: YDCColors.subLightTextColor, width: 1),
                        ),
                        RaisedButton(
                          onPressed: sureEvent,
                          color: YDCColors.color_magenta,
                          elevation: 0.2,
                          highlightElevation: 0.2,
                          padding: EdgeInsets.only(
                              left: 49, top: 14, right: 49, bottom: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '确定',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(36)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}