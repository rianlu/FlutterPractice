import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Text Style'),
      ),
      body: Column(
        children: [
          Text(
            'Hello World' * 10,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.grey),
          ),
          Text('Hello World' * 10,
              maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(
            'Hello World',
            textScaleFactor: 1.5,
          ),
          Text(
            'Hello World',
            style: TextStyle(
                fontSize: 18.0,
                height: 1.2,
                fontFamily: 'Courier',
                color: Colors.blue,
                // backgroundColor: Colors.yellow,
                background: Paint()..color = Colors.yellow,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed),
          ),
          Text.rich(TextSpan(children: [
            TextSpan(text: 'Home: '),
            TextSpan(
                text: 'https://flutterchina.club',
                style: TextStyle(color: Colors.blue),
                recognizer: null),
          ])),
          DefaultTextStyle(
            style: TextStyle(color: Colors.red[400], fontSize: 20.0),
            textAlign: TextAlign.start,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello World'),
                Text('I am Jack'),
                Text(
                  'Hello World',
                  // 不继承默认样式
                  style: TextStyle(inherit: false, color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    ),
  ));
}
