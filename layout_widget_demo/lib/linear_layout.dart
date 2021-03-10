import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Linear Layout'),
          ),
          body:
              // NormalColumnTest()
              NestColumnTest()),
    ),
  );
}

class NormalColumnTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [RowTest(), ColumnTest()]);
  }
}

class RowTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 主轴居中对齐，宽度默认铺满，即mainAxisSize: MainAxisSize.max
        // 结果：居中显示
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(" hello world "),
            Text(" I am Jack "),
          ],
        ),
        // 宽度为最小宽度，所以mainAxisAlignment不起作用
        // 结果：左对齐
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(" hello world "),
            Text(" I am Jack "),
          ],
        ),
        // 布局方向从右到左，所以以右边为基准
        // 结果：左对齐
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Text(" hello world "),
            Text(" I am Jack "),
          ],
        ),
        // 纵轴方向为从下往上，所以以底部为基准
        // 结果：底部对齐
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Text(
              " hello world ",
              style: TextStyle(fontSize: 30.0),
            ),
            Text(" I am Jack "),
          ],
        ),
      ],
    );
  }
}

class ColumnTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 对于Column，crossAxisAlignment相当于设置水平方向的对齐方式
    // 结果：文本水平居中
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("hi"),
        Text("world"),
      ],
    );
  }
}

class NestColumnTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // 对于嵌套Column/Row，如果外层不使用Expanded包裹
            // 则设置mainAxisSize: MainAxisSize.max无效
            Expanded(
              child: Container(
                color: Colors.red,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("hello world "),
                    Text("I am Jack "),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
