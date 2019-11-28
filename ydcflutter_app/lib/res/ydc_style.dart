import 'package:flutter/material.dart';

/**
 * 颜色配置
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class YDCColors {

  static const Color white = Color(0xFFFFFFFF);

  static const Color colorPrimary = Color(0xff4caf50);
  static const Color colorPrimaryDark = Color(0xff388E3C);
  static const Color colorAccent = Color(0xff8BC34A);
  static const Color colorPrimaryLight = Color(0xffC8E6C9);

  static const Color primaryText = Color(0xff212121);
  static const Color secondaryText = Color(0xff757575);
  static const Color black_3 = Color(0xff333333);

  static const Color dividerColor = Color(0xffBDBDBD);

  static const Color bg = Color(0xffF9F9F9);
  static const Color color_F9F9F9 = Color(0xffF9F9F9);

  static const Color color_999 = Color(0xff999999);
  static const Color color_666 = Color(0xff666666);

  static const Color color_f3f3f3 = Color(0xfff3f3f3);
  static const Color color_f1f1f1 = Color(0xfff1f1f1);
  static const Color color_fff = Color(0xffffffff);

  /**
   * 品红
   */
  static const Color color_magenta= Color(0xffe9546b);

  static const int primaryIntValue = 0xFF24292E;

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryIntValue,
    const <int, Color>{
      50: const Color(primaryIntValue),
      100: const Color(primaryIntValue),
      200: const Color(primaryIntValue),
      300: const Color(primaryIntValue),
      400: const Color(primaryIntValue),
      500: const Color(primaryIntValue),
      600: const Color(primaryIntValue),
      700: const Color(primaryIntValue),
      800: const Color(primaryIntValue),
      900: const Color(primaryIntValue),
    },
  );

  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";
  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";

  static const Color primaryValue = Color(0xFF24292E);
  static const Color primaryLightValue = Color(0xFF42464b);
  static const Color primaryDarkValue = Color(0xFF121917);

  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color miWhite = Color(0xffececec);
  static const Color actionBlue = Color(0xff267aff);
  static const Color subTextColor = Color(0xff959595);
  static const Color subLightTextColor = Color(0xffc4c4c4);

  static const Color mainBackgroundColor = miWhite;

  static const Color mainTextColor = primaryDarkValue;
  static const Color textColorWhite = white;



  /* 主题列表 */
  static const Map themeColor = {
    0: {//green
      "primaryColor": Color(0xff4caf50),
      "primaryColorDark": Color(0xff388E3C),
      "colorAccent": Color(0xff8BC34A),
      "colorPrimaryLight": Color(0xffC8E6C9),
    },
    1:{//red
      "primaryColor": Color(0xffF44336),
      "primaryColorDark": Color(0xffD32F2F),
      "colorAccent": Color(0xffFF5252),
      "colorPrimaryLight": Color(0xffFFCDD2),
    },
    2:{//blue
      "primaryColor": Color(0xff2196F3),
      "primaryColorDark": Color(0xff1976D2),
      "colorAccent": Color(0xff448AFF),
      "colorPrimaryLight": Color(0xffBBDEFB),
    },
    3:{//pink
      "primaryColor": Color(0xffE91E63),
      "primaryColorDark": Color(0xffC2185B),
      "colorAccent": Color(0xffFF4081),
      "colorPrimaryLight": Color(0xffF8BBD0),
    },
    4:{//purple
      "primaryColor": Color(0xff673AB7),
      "primaryColorDark": Color(0xff512DA8),
      "colorAccent": Color(0xff7C4DFF),
      "colorPrimaryLight": Color(0xffD1C4E9),
    },
    5:{//grey
      "primaryColor": Color(0xff9E9E9E),
      "primaryColorDark": Color(0xff616161),
      "colorAccent": Color(0xff9E9E9E),
      "colorPrimaryLight": Color(0xffF5F5F5),
    },
    6:{//black
      "primaryColor": Color(0xff333333),
      "primaryColorDark": Color(0xff000000),
      "colorAccent": Color(0xff666666),
      "colorPrimaryLight": Color(0xff999999),
    },
  };

}

///文本样式
class YDCConstant {


  static const lagerTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  static const minText = TextStyle(
    color: YDCColors.subLightTextColor,
    fontSize: minTextSize,
  );

  static const smallTextWhite = TextStyle(
    color: YDCColors.textColorWhite,
    fontSize: smallTextSize,
  );

  static const smallText = TextStyle(
    color: YDCColors.mainTextColor,
    fontSize: smallTextSize,
  );

  static const smallTextBold = TextStyle(
    color:YDCColors.mainTextColor,
    fontSize: smallTextSize,
    fontWeight: FontWeight.bold,
  );

  static const smallSubLightText = TextStyle(
    color: YDCColors.subLightTextColor,
    fontSize: smallTextSize,
  );

  static const smallActionLightText = TextStyle(
    color: YDCColors.actionBlue,
    fontSize: smallTextSize,
  );

  static const smallMiLightText = TextStyle(
    color: YDCColors.miWhite,
    fontSize: smallTextSize,
  );

  static const smallSubText = TextStyle(
    color: YDCColors.subTextColor,
    fontSize: smallTextSize,
  );

  static const middleText = TextStyle(
    color: YDCColors.mainTextColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleTextWhite = TextStyle(
    color: YDCColors.textColorWhite,
    fontSize: middleTextWhiteSize,
  );

  static const middleSubText = TextStyle(
    color: YDCColors.subTextColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleSubLightText = TextStyle(
    color: YDCColors.subLightTextColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleTextBold = TextStyle(
    color: YDCColors.mainTextColor,
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleTextWhiteBold = TextStyle(
    color: YDCColors.textColorWhite,
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleSubTextBold = TextStyle(
    color: YDCColors.subTextColor,
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const normalText = TextStyle(
    color: YDCColors.mainTextColor,
    fontSize: normalTextSize,
  );

  static const normalTextBold = TextStyle(
    color:YDCColors.mainTextColor,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalSubText = TextStyle(
    color: YDCColors.subTextColor,
    fontSize: normalTextSize,
  );

  static const normalTextWhite = TextStyle(
    color: YDCColors.textColorWhite,
    fontSize: normalTextSize,
  );

  static const normalTextMitWhiteBold = TextStyle(
    color: YDCColors.miWhite,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextActionWhiteBold = TextStyle(
    color: YDCColors.actionBlue,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextLight = TextStyle(
    color: YDCColors.primaryLightValue,
    fontSize: normalTextSize,
  );

  static const largeText = TextStyle(
    color: YDCColors.mainTextColor,
    fontSize: bigTextSize,
  );

  static const largeTextBold = TextStyle(
    color: YDCColors.mainTextColor,
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextWhite = TextStyle(
    color: YDCColors.textColorWhite,
    fontSize: bigTextSize,
  );

  static const largeTextWhiteBold = TextStyle(
    color: YDCColors.textColorWhite,
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhite = TextStyle(
    color: YDCColors.textColorWhite,
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeText = TextStyle(
    color: YDCColors.primaryValue,
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );
}
