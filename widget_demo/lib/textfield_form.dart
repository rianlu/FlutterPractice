import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          title: Text('TextField And Form'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          LoginTextFieldWidget(),
          FocusTestRoute(),
          CustomTextFieldTheme(),
          FormRoute()
        ]))),
  ));
}

class LoginTextFieldWidget extends StatefulWidget {
  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

// 两种文本变化监听方式
// 1. onChanged
// 2. controller.addListener
class _LoginTextFieldState extends State<LoginTextFieldWidget> {
  var _nameController = TextEditingController();
  var _selectionController = TextEditingController();

  @override
  void initState() {
    _nameController.addListener(() {
      print('Controller: ${_nameController.text}');
    });

    // 选中部分内容
    _selectionController.text = 'Hello World';
    _selectionController.selection = TextSelection(
        baseOffset: 2, extentOffset: _selectionController.text.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          decoration: InputDecoration(
              labelText: '用户名',
              hintText: '用户名',
              prefixIcon: Icon(Icons.person)),
          controller: _nameController,
          onChanged: (text) {
            print('onChanged: $text');
          },
        ),
        TextField(
          decoration: InputDecoration(
              labelText: '密码', hintText: '密码', prefixIcon: Icon(Icons.lock)),
          obscureText: true,
        ),
        TextField(
          controller: _selectionController,
        )
      ],
    );
  }
}

class FocusTestRoute extends StatefulWidget {
  @override
  _FocusTestState createState() => _FocusTestState();
}

class _FocusTestState extends State<FocusTestRoute> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  @override
  void initState() {
    focusNode1.addListener(() {
      print('Input 1 Focus: ${focusNode1.hasFocus}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          focusNode: focusNode1,
          decoration: InputDecoration(labelText: 'Input 1'),
        ),
        TextField(
          focusNode: focusNode2,
          decoration: InputDecoration(labelText: 'Input 2'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(focusNode2);
              },
              child: Text('移动焦点'),
            ),
            RaisedButton(
              onPressed: () {
                // 当失去全部焦点，键盘会自动收起
                focusNode1.unfocus();
                focusNode2.unfocus();
              },
              child: Text('关闭键盘'),
            )
          ],
        ),
        // 自定义样式
        TextField(
          decoration: InputDecoration(
            labelText: '用户名',
            prefixIcon: Icon(Icons.person),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrangeAccent)),
          ),
        )
      ],
    );
  }
}

class CustomTextFieldTheme extends StatefulWidget {
  @override
  _CustomTextFieldThemeState createState() => _CustomTextFieldThemeState();
}

class _CustomTextFieldThemeState extends State<CustomTextFieldTheme> {
  bool _customTextFieldFocus = false;
  FocusNode customFocusNode = FocusNode();

  @override
  void initState() {
    // 控制Container嵌套的焦点选中状态变化
    customFocusNode.addListener(() {
      setState(() {
        _customTextFieldFocus = customFocusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            hintColor: Colors.grey[200], // 下划线颜色
            inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.green), // label 样式
                hintStyle:
                    TextStyle(color: Colors.red[200], fontSize: 14.0) // 提示文本样式
                )),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: '用户名',
                  hintText: '请输入用户名',
                  prefixIcon: Icon(Icons.person)),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '请输入密码',
                  prefixIcon: Icon(Icons.lock),
                  hintStyle: TextStyle(color: Colors.purpleAccent)),
              obscureText: true,
            ),
            // Container 嵌套样式
            Container(
              child: TextField(
                focusNode: customFocusNode,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: '请输入邮箱',
                    prefixIcon: Icon(Icons.email),
                    border: InputBorder.none),
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: _customTextFieldFocus
                              ? Colors.green
                              : Colors.grey,
                          width: _customTextFieldFocus ? 2.0 : 1.0))),
            )
          ],
        ));
  }
}

class FormRoute extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: '用户名', hintText: '请输入用户名'),
          validator: (value) {
            return value.trim().length > 0 ? null : '用户名不能为空';
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: '密码', hintText: '请输入密码'),
          validator: (value) {
            return value.trim().length >= 6 ? null : '密码不能小于6位';
          },
        ),
        Builder(builder: (context) {
          return RaisedButton(
            child: Text('Login'),
            onPressed: () {
              Form.of(context).validate();
            },
          );
        })
      ],
    );
  }
}
