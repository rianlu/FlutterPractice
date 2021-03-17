import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Pointer Event'),
      ),
      body: Column(
        children: [PointerEventRoute(), PointerEventBehaviorRoute(), IgnorePointerEventRoute()],
      ),
    ),
  ));
}

class PointerEventRoute extends StatefulWidget {
  @override
  _PointerEventState createState() => _PointerEventState();
}

class _PointerEventState extends State<PointerEventRoute> {
  PointerEvent _pointerEvent;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: double.infinity,
        height: 300.0,
        child: Text(
          _pointerEvent.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      onPointerDown: (event) => setState(() => _pointerEvent = event),
      onPointerMove: (event) => setState(() => _pointerEvent = event),
      onPointerUp: (event) => setState(() => _pointerEvent = event),
    );
  }
}

class PointerEventBehaviorRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Listener(
      // HitTestBehavior.deferToChild 只有当前点击的Text组件可以触发
      // HitTestBehavior.opaque 整个Widget都可以触发点击事件
      // HitTestBehavior.translucent 顶部组件及底部组件都能触发
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.tight(Size(300.0, 150.0)),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.orange),
              child: Center(
                child: Text('Box A'),
              ),
            ),
          ),
          Listener(
            behavior: HitTestBehavior.translucent,
            child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(100.0, 100.0))),
            onPointerDown: (event) => print('down Top'),
          )
        ],
      ),
      onPointerDown: (event) => print('down A'),
    );
  }
}

class IgnorePointerEventRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Listener(
      child: AbsorbPointer(
        child: Listener(
          child: Container(
            color: Colors.teal,
            width: 200.0,
            height: 200.0,
            child: Text('Absorb'),
          ),
          onPointerDown: (event) => print('container'),
        ),
      ),
      onPointerDown: (event) => print('absorb'),
    ),
    Listener(
      child: IgnorePointer(
        child: Listener(
          child: Container(
            color: Colors.teal,
            width: 200.0,
            height: 200.0,
            child: Text('Ignore'),
          ),
          onPointerDown: (event) => print('container'),
        ),
      ),
      onPointerDown: (event) => print('ignore'),
    )
    ],);
  }
}
