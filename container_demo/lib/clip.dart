import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Clip'),
      ),
      body: ClipRoute(),
    ),
  ));
}

class ClipRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget avatar =
        Image.network('https://book.flutterchina.club/assets/img/book.17ed07e5.png', width: 60.0);
    return Container(
      color: Colors.blue[200],
      child: Center(
      child: Column(
        children: [
          avatar,
          // 正方形裁剪为圆，矩形裁剪为椭圆
          ClipOval(child: avatar),
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: avatar,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .5,
                child: avatar,
              ),
              Text(
                'Hello World',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRect(
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,
                  child: avatar,
                ),
              ),
              Text('Hello World', style: TextStyle(color: Colors.black))
            ],
          ),
          ClipRect(
            clipper: MyClipper(),
            child: avatar,
          )
        ],
      ),
    ),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true; 
  }
}