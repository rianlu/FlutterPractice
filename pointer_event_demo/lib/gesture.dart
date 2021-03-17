import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Gesture'),
      ),
      body:
          // GestureDetectorRoute(),
          // DragRoute(),
          // ScaleRoute(),
          // GestureRecognizerRoute(),
          // BothDirectionRoute(),
          // GestureConflictRoute(),
          GestureConflictRoute(),
    ),
  ));
}

class GestureDetectorRoute extends StatefulWidget {
  @override
  _GestureDetectorState createState() => _GestureDetectorState();
}

class _GestureDetectorState extends State<GestureDetectorRoute> {
  String _operation = "";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          alignment: Alignment.center,
          width: 200.0,
          height: 200.0,
          color: Colors.blue,
          child: Text(
            _operation,
            style: TextStyle(color: Colors.white),
          ),
        ),
        // 如果同时监听 onTap 和 onDoubleTap ，则 onTap 会有200ms左右的延迟，为了判断是不是 onDoubleTap
        onTap: () => updateText('onTap'),
        onDoubleTap: () => updateText('onDoubleTap'),
        onLongPress: () => updateText('onLongPress'));
  }

  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }
}

class DragRoute extends StatefulWidget {
  @override
  _DragRouteState createState() => _DragRouteState();
}

class _DragRouteState extends State<DragRoute>
    with SingleTickerProviderStateMixin {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          // 如果只设置一个属性，则代表只在一个方向上进行拖动
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text('A'),
            ),
            // 相对于屏幕左上角（非父组件）
            onPanDown: (details) => print('按下：${details.globalPosition}'),
            onPanUpdate: (details) {
              setState(() {
                _top += details.delta.dy;
                _left += details.delta.dx;
              });
            },
            onPanEnd: (details) => print('结束，拖动速度：${details.velocity}'),
          ),
        )
      ],
    );
  }
}

class ScaleRoute extends StatefulWidget {
  @override
  _ScaleRouteState createState() => _ScaleRouteState();
}

class _ScaleRouteState extends State<ScaleRoute> {
  double _width = 200.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Image.asset(
          'images/test.jpeg',
          width: _width,
        ),
        onScaleUpdate: (details) {
          setState(() {
            _width = 200.0 * details.scale.clamp(0.1, 4.0);
          });
        },
      ),
    );
  }
}

class GestureRecognizerRoute extends StatefulWidget {
  @override
  _GestureRecognizerState createState() => _GestureRecognizerState();
}

class _GestureRecognizerState extends State<GestureRecognizerRoute> {
  TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer();
  bool _toggle = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(text: 'Hello World'),
        TextSpan(
            text: '点我变色',
            style: TextStyle(
                fontSize: 30.0, color: _toggle ? Colors.teal : Colors.blue),
            recognizer: _gestureRecognizer
              ..onTap = () {
                setState(() {
                  _toggle = !_toggle;
                });
              }),
        TextSpan(text: '你好世界')
      ])),
    );
  }

  @override
  void dispose() {
    _gestureRecognizer.dispose();
    super.dispose();
  }
}

// 垂直或水平拖动
class BothDirectionRoute extends StatefulWidget {
  @override
  _BothDirectionRouteState createState() => _BothDirectionRouteState();
}

class _BothDirectionRouteState extends State<BothDirectionRoute>
    with SingleTickerProviderStateMixin {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text('A'),
            ),
            onVerticalDragUpdate: (details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
            onHorizontalDragUpdate: (details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
          ),
        )
      ],
    );
  }
}

class GestureConflictRoute extends StatefulWidget {
  @override
  _GestureConflictRouteState createState() => _GestureConflictRouteState();
}

class _GestureConflictRouteState extends State<GestureConflictRoute>
    with SingleTickerProviderStateMixin {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _top,
          left: _left,
          // 手势冲突使用Listener
          child: Listener(
            onPointerDown: (event) => print('onPointerDown'),
            onPointerUp: (event) => print('onPointerUp'),
            child: GestureDetector(
              child: CircleAvatar(
                child: Text('A'),
              ),
              onPanDown: (details) => print('onPanDown'),
              onTapDown: (details) => print('onTapDown'),
              onTapUp: (details) => print('onTapUp'),
              onPanUpdate: (details) {
                setState(() {
                  _top += details.delta.dy;
                  _left += details.delta.dx;
                });
              },
              onPanEnd: (details) => print('onPanEnd'),
            ),
          ),
        )
      ],
    );
  }
}
