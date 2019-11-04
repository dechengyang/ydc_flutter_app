import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ydcflutter_app/login/LoginPage.dart';

void main() => runApp(new TalkcasuallyApp());
final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class TalkcasuallyApp  extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
//      title: '谈天说地',
//      theme: defaultTargetPlatform == TargetPlatform.iOS
//          ? kIOSTheme
//          : kDefaultTheme,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.grey[50],
        scaffoldBackgroundColor: Colors.grey[50],
        dialogBackgroundColor: Colors.grey[50],
        primaryColorBrightness: Brightness.light,
        buttonColor: Colors.blue,
        iconTheme: new IconThemeData(
          color: Colors.grey[700],
        ),
        hintColor: Colors.grey[400],
      ),
      title: '纸聊',

//      supportedLocales: [
//        const Locale('zh', 'CH'),
//        const Locale('en', 'US'),
//      ],

      home:  new LoginPage(),
    );
  }
}





