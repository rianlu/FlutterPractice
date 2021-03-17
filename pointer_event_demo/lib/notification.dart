import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body:
          // NotificationListenerRoute(),
          CustomNotificationRoute(),
    ),
  ));
}

class NotificationListenerRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification: (notification) {
          switch (notification.runtimeType) {
            case ScrollStartNotification:
              print("开始滚动");
              break;
            case ScrollUpdateNotification:
              print("正在滚动");
              break;
            case ScrollEndNotification:
              print("滚动停止");
              break;
            case OverscrollNotification:
              print("滚动到边界");
              break;
          }
          return true;
        },
        child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('$index'),
              );
            }));
  }
}

class CustomNotification extends Notification {
  CustomNotification(this.msg);
  final String msg;
}

class CustomNotificationRoute extends StatefulWidget {
  @override
  _CustomNotificationRouteState createState() =>
      _CustomNotificationRouteState();
}

class _CustomNotificationRouteState extends State<CustomNotificationRoute> {
  String _msg = '';

  @override
  Widget build(BuildContext context) {
    return NotificationListener<CustomNotification>(
      onNotification: (notification) {
        print(notification.msg);
        return false;
      },
      child: NotificationListener<CustomNotification>(
          onNotification: (notification) {
            setState(() {
              _msg += notification.msg + " ";
            });
            // 设置为true，则阻止冒泡
            return true;
          },
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Builder(builder: (context) {
                return ElevatedButton(
                  child: Text('发送自定义通知'),
                  onPressed: () =>
                      CustomNotification('Hello').dispatch(context),
                );
              }),
              Text(_msg)
            ],
          ))),
    );
  }
}
