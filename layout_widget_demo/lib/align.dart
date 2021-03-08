import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          title: Text('Flow Layout'),
        ),
        body: AlignTest()),
  ));
}

class AlignTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // width: 120.0,
          // height: 120.0,
          color: Colors.blue[50],
          child: Align(
            widthFactor: 2,
            heightFactor: 2,
            alignment: Alignment.topRight,
            child: FlutterLogo(
              size: 60.0,
            ),
          ),
        ),
        Container(
          color: Colors.blue[50],
          child: Align(
            widthFactor: 2,
            heightFactor: 2,
            // 坐标原点为矩形的中心点
            alignment: Alignment(2, 0.0),
            child: FlutterLogo(
              size: 60.0,
            ),
          ),
        ),
        Container(
          color: Colors.blue[50],
          child: Align(
            widthFactor: 2,
            heightFactor: 2,
            // 坐标原点为矩形的中心点
            alignment: FractionalOffset(0.2, 0.6),
            child: FlutterLogo(
              size: 60.0,
            ),
          ),
        ),
        // 未设置widthFactor/heightFactor会铺满容器
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.green),
          child: Center(
            child: Text("xxx"),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.green),
          child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: Text("xxx"),
          ),
        )
      ],
    );
  }
}
