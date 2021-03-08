import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Stack Layout'),
      ),
      body: StackTest()
      ),
  ));
}

class StackTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        // 会使未定位的组件铺满Stack
        // fit: StackFit.expand,
        children: [
          Container(
            child: Text(
              'Hello World',
              style: TextStyle(color: Colors.yellow),
            ),
            color: Colors.blue,
          ),
          Positioned(
            left: 18.0,
            child: Text('I am Jack'),
          ),
          Positioned(
            top: 18.0,
            child: Text('Your Friend'),
          )
        ],
      ),
    );
  }
}
