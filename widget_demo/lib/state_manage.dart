import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: '状态管理',
    theme: ThemeData(primarySwatch: Colors.orange),
    // home: TapboxA(),
    // home: ParentWidget(),
    home: ParentWidgetC(),
  ));
}

// Widget管理自身状态
class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  _TapboxAState createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(color: _active ? Colors.orange : Colors.grey),
      ),
    );
  }
}

// 父Widget管理子Widget的状态
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(color: active ? Colors.orange : Colors.grey),
      ),
    );
  }
}

// 混合状态管理
class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetStateC createState() => _ParentWidgetStateC();
}

class _ParentWidgetStateC extends State<ParentWidgetC> {
  bool active = false;

  void _handleBoxColorChanged(bool newValue) {
    setState(() {
      active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxC(
        active: active,
        onChanged: _handleBoxColorChanged,
      ),
    );
  }
}

class TapboxC extends StatefulWidget {
  TapboxC({
    Key key,
    this.active: false,
    @required this.onChanged
  }) : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  _TapboxStateC createState() => _TapboxStateC();
}

class _TapboxStateC extends State<TapboxC> {
  bool _highlight = false;

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  void _handleTapUp(TapUpDetails tapUpDetails) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapDown(TapDownDetails tapDownDetails) {
    setState(() {
      _highlight = true;
    });
  }

    void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      onTapUp: _handleTapUp,
      onTapDown: _handleTapDown,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(
            color: widget.active ? Colors.orange : Colors.grey,
            border: _highlight
                ? Border.all(color: Colors.green, width: 10.0)
                : null),
      ),
    );
  }
}
