import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    appBar: AppBar(
      title: Text('Transform'),
    ),
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(50.0),
            child: Container(
              color: Colors.black,
              child: Transform(
                alignment: Alignment.topRight,
                transform: Matrix4.skewY(0.3),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: Text('Hello World'),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(50.0),
            child: Container(
              color: Colors.red,
              child: Transform.translate(
                offset: Offset(-5.0, -5.0),
                child: Text('Hello World'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(50.0),
            child: Container(
              color: Colors.green,
              child: Transform.rotate(
                angle: math.pi / 2,
                child: Text('Hello World'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(50.0),
            child: Container(
              color: Colors.blue,
              child: Transform.scale(
                scale: 1.5,
                child: Text('Hello World'),
              ),
            ),
          ),
          // 先旋转再平移和先平移再旋转结果不一样
          Padding(
            padding: EdgeInsets.all(50.0),
            child: Container(
              color: Colors.blue,
              child: Transform.translate(
                offset: Offset(10.0, 0.0),
                child: Transform.rotate(
                  angle: math.pi / 2,
                  child: Text('Hello World'),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(50.0),
            child: Container(
              color: Colors.blue,
              child: Transform.rotate(
                angle: math.pi / 2,
                child: Transform.translate(
                  offset: Offset(10.0, 0.0),
                  child: Text('Hello World'),
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(50.0),
              child: Row(children: [
                // 作用于布局阶段，所以实际占用空间为旋转后的占用空间
                // 而Transform.rotate作用于绘制阶段，占用空间已经在布局阶段就生成了
                Container(
                color: Colors.blue,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text('Hello World'),
                ),
              ),
              Text('Hello World')
              ],))
        ],
      ),
    ),
  )));
}
