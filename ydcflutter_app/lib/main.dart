import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ydcflutter_app/ydcapp.dart';

void main() => runApp( new YDCApp());


class YDCApp  extends StatelessWidget {

  YDCApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new YDCFlutterApp();
  }
}
