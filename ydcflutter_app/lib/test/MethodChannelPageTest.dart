import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ydcflutter_app/redux/user_redux.dart';

import 'package:ydcflutter_app/test/bean/YDCState.dart';
import 'package:flutter/services.dart';

class TestMethodChannelPage extends StatefulWidget {
  @override
  State createState() => new _TestMethodChannelPageState();
}

class _TestMethodChannelPageState extends State<TestMethodChannelPage> {

  BuildContext mContext;
  static const platform = const MethodChannel('com.ydc.ydcflutter_app/battery');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new RaisedButton(
              child: new Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            new Text(_batteryLevel),
          ],
        ),
      ),
    );
  }


  Widget dividerWidget = new Container(
    //margin: const EdgeInsets.only( left: 10.0,right: 10.0),
      child: new Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
          child:
          new Divider(height: 1.0, indent: 0.0, color: Color(0xFFe5e5e5))
      )

  );

  @override
  void dispose() {
    super.dispose();
  }
}

