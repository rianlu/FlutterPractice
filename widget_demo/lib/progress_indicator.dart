import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('进度指示器')),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
                LinearProgressIndicator(
                  value: .5,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.orange[400]),
                ),
                CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  strokeWidth: 5.0,
                ),
                CircularProgressIndicator(
                  value: .5,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  strokeWidth: 10.0,
                ),
                // 进度指示器依据父容器调整大小
                SizedBox(
                  height: 10,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                ),
                SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    strokeWidth: 5.0,
                  ),
                ),
                ProgressAnimationRoute()
              ],
            ),
          ))));
}

// 第三方库：https://pub.flutter-io.cn/packages/flutter_spinkit

class ProgressAnimationRoute extends StatefulWidget {
  _ProgressAnimationState createState() => _ProgressAnimationState();
}

class _ProgressAnimationState extends State<ProgressAnimationRoute> with SingleTickerProviderStateMixin {

  AnimationController _animationController;

  @override
    void initState() {
      _animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
      _animationController.forward();
      _animationController.addListener(() => setState(() => {}));
      super.initState();
    }

  @override
    Widget build(BuildContext context) {
      return LinearProgressIndicator(
        backgroundColor: Colors.grey[200],
        valueColor: ColorTween(begin: Colors.green, end: Colors.blue).animate(_animationController),
        value: _animationController.value,
        );
    }

    @override
      void dispose() {
        _animationController.dispose();
        super.dispose();
      }
}