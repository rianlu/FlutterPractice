import 'package:flutter/material.dart';
import 'event_bus.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginRoute(),
    ),
  ));
}

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  bool _loginState = false;

  @override
  Widget build(BuildContext context) {
    bus.on('login', (arg) {
      if (arg is bool) {
        print(arg);
      }
      setState(() {
        _loginState = true;
      });
    });
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(TextSpan(children: [
            TextSpan(text: '当期状态：'),
            TextSpan(
                text: _loginState ? '已登录' : '未登录',
                style:
                    TextStyle(color: _loginState ? Colors.green : Colors.red))
          ])),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
                child: Text('登录'),
                onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MainUserInfoRoute();
                    }))),
          ),
        ],
      ),
    );
  }
}

class MainUserInfoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户信息'),
      ),
      body: UserInfoRoute(),
    );
  }
}

class UserInfoRoute extends StatefulWidget {
  @override
  _UserInfoRouteState createState() => _UserInfoRouteState();
}

class _UserInfoRouteState extends State<UserInfoRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('全局通知'),
        onPressed: () => bus.emit('login', true),
      ),
    );
  }
}
