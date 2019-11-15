import 'dart:ui';
import 'package:flutter/material.dart';

/**
 * 自定义底部菜单
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class YDCBottomSheet extends StatefulWidget {
  YDCBottomSheet({Key key, this.list, this.onItemClickListener})
      : assert(list != null),
        super(key: key);
  final list;
  final OnItemClickListener onItemClickListener;
  @override
  _YDCBottomSheetState createState() => _YDCBottomSheetState();
}
typedef OnItemClickListener = void Function(int index);

class _YDCBottomSheetState extends State<YDCBottomSheet> {
  OnItemClickListener onItemClickListener;
  var itemCount;
  double itemHeight = 44;
  var borderColor = Colors.grey;
  double circular = 10;
  @override
  void initState() {
    super.initState();
    onItemClickListener = widget.onItemClickListener;
  }
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size screenSize = MediaQuery.of(context).size;

    var deviceWidth = orientation == Orientation.portrait
        ? screenSize.width
        : screenSize.height;
    print('devide width');
    print(deviceWidth);

    /// *2-1是为了加分割线，最后还有一个cancel，所以加1
    itemCount = (widget.list.length * 2 - 1) + 1;
    var height = ((widget.list.length+1) * 48).toDouble();
    var cancelContainer = Container(
        height: itemHeight,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white, // 底色
          borderRadius: BorderRadius.circular(circular),
        ),
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text("取消",
              style: TextStyle(
                  fontFamily: 'Robot',
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  color: Color(0xff333333),
                  fontSize: 18),
            ),
          ),
        ));
    var listview = ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          if (index == itemCount - 1) {
            return new Container(
              child: cancelContainer,
              margin: const EdgeInsets.only(top: 10),
            );
          }
          return getItemContainer(context, index);
        });

    var totalContainer = Container(
      child: listview,
      height: height,
      width: deviceWidth * 0.98,
    );

    var stack = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          bottom: 0,
          child: totalContainer,
        ),
      ],
    );
    return stack;
  }



  Widget getItemContainer(BuildContext context, int index) {
    if (widget.list == null) {
      return Container();
    }
    if (index.isOdd) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Divider(
          height: 0.0,
          color: borderColor,
        ),
      );
    }

    var borderRadius;
    var margin;
    var border;
    var borderAll = Border.all(color: borderColor, width: 0.5);
    var borderSide = BorderSide(color: borderColor, width: 0.5);
    var isFirst = false;
    var isLast = false;

    /// 只有一个元素
    if (widget.list.length == 1) {
      borderRadius = BorderRadius.circular(circular);
      margin = EdgeInsets.only(bottom: 10, left: 10, right: 10);
      border = borderAll;
    } else if (widget.list.length > 1) {
      /// 第一个元素
      if (index == 0) {
        isFirst = true;
        borderRadius = BorderRadius.only(topLeft: Radius.circular(circular), topRight: Radius.circular(circular));
        margin = EdgeInsets.only(left: 10, right: 10,);
        border = Border(top: borderSide, left: borderSide, right: borderSide);
      } else if (index == itemCount - 2) {
        isLast = true;
        /// 最后一个元素
        borderRadius = BorderRadius.only(bottomLeft: Radius.circular(circular), bottomRight: Radius.circular(circular));
        margin = EdgeInsets.only( left: 10, right: 10);
        border = Border(bottom: borderSide, left: borderSide, right: borderSide);
      } else {
        /// 其他位置元素
        margin = EdgeInsets.only(left: 10, right: 10);
        border = Border(left: borderSide, right: borderSide);
      }
    }
    var isFirstOrLast = isFirst || isLast;
    int listIndex = index ~/ 2;
    var text = widget.list[listIndex];
    var contentText = Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          color: Color(0xFF333333),
          fontSize: 18),
    );

    var center;
    if (!isFirstOrLast) {
      center = Center(
        child: contentText,
      );
    }
    var itemContainer = Container(
        height: itemHeight,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white, // 底色
          borderRadius: borderRadius,
          border: border,
        ),
        child: center);
    var onTap2 = () {
      if (onItemClickListener != null) {
        onItemClickListener(index);
      }
    };
    var stack = Stack(
      alignment: Alignment.center,
      children: <Widget>[itemContainer, contentText],
    );
    var getsture = GestureDetector(
      onTap: onTap2,
      child: isFirstOrLast ? stack : itemContainer,
    );
    return getsture;
  }
}