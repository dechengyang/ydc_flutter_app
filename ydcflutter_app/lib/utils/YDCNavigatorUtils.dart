
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 页面跳转管理
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class YDCNavigatorUtils {

  //弹出 dialog
  static Future<T> showYDCDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(

            ///不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: new SafeArea(child: builder(context)));
        });
  }
}