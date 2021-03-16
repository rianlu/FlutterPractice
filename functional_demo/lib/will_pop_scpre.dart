import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('WillPopScope'),
      ),
      body: WillPopScopeRoute(),
    ),
  ));
}

class WillPopScopeRoute extends StatefulWidget {
  @override
  _WillPopScopeRouteState createState() => _WillPopScopeRouteState();
}

class _WillPopScopeRouteState extends State<WillPopScopeRoute> {
  DateTime _lastPressAt;
  bool isPressedBack = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          var tempState = false;
          var needQuit = false;
          if (_lastPressAt == null ||
              DateTime.now().difference(_lastPressAt) > Duration(seconds: 1)) {
            _lastPressAt = DateTime.now();
            tempState = true;
            needQuit = false;
          } else {
            tempState = true;
          }
          setState(() {
            isPressedBack = tempState;
          });
          return needQuit;
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(isPressedBack ? '再按一次退出程序' : '返回拦截（连按两次退出程序）'),
        ));
  }
}
