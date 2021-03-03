import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Switch & Checkbox'),
      ),
      body: SwitchAndCheckboxRoute(),
    ),
  ));
}

class SwitchAndCheckboxRoute extends StatefulWidget {
  @override
  _SwitchAndCheckboxState createState() => _SwitchAndCheckboxState();
}

// 状态由父组件进行管理
class _SwitchAndCheckboxState extends State<SwitchAndCheckboxRoute> {
  bool _switchSelected = false;
  bool _checkboxSelected = false;
  bool _checkboxSelectedWithTristate = false;

  void _switchChanged(bool value) {
    setState(() {
      _switchSelected = value;
    });
  }

  void _checkboxChanged(bool value) {
    setState(() {
      _checkboxSelected = value;
    });
  }

  void _checkboxChangedWithTristate(bool value) {
    setState(() {
      _checkboxSelectedWithTristate = value;
      print('Checkbox State: $_checkboxSelectedWithTristate');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
          value: _switchSelected,
          onChanged: _switchChanged,
          activeColor: Colors.teal,
        ),
        Checkbox(
          value: _checkboxSelected,
          onChanged: _checkboxChanged,
        ),
        Checkbox(
          value: _checkboxSelectedWithTristate,
          onChanged: _checkboxChangedWithTristate,
          // 三态，默认为false，中间态为null
          tristate: true,
        ),
      ],
    );
  }
}
