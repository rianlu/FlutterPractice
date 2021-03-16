import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ThemeRoute()));
}

class MainRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color & Theme'),
      ),
      body: Column(
        children: [
          NavBarLuminance(
            color: Colors.pink,
            title: '亮色标题',
          ),
          NavBarLuminance(
            color: Colors.pink[100],
            title: '暗色标题',
          )
        ],
      ),
    );
  }
}

// 字符串转Color对象
class ColorTest extends StatelessWidget {
  final String color = 'FFB6C1';
  @override
  Widget build(BuildContext context) {
    return Container(
      // 三种方式
      // color: Color(0xff00ff00),
      // color: Color(int.parse(color, radix: 16)|0xFF000000),
      color: Color(int.parse(color, radix: 16)).withAlpha(255),
    );
  }
}

class NavBarLuminance extends StatelessWidget {
  NavBarLuminance({Key key, @required this.title, @required this.color})
      : super(key: key);
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(minWidth: double.infinity, minHeight: 52.0),
      decoration: BoxDecoration(color: color, boxShadow: [
        BoxShadow(
            color: Colors.black26, offset: Offset(0.0, 3.0), blurRadius: 3.0)
      ]),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color:
                color.computeLuminance() < 0.5 ? Colors.white : Colors.black),
      ),
    );
  }
}

class ThemeRoute extends StatefulWidget {
  @override
  _ThemeRouteState createState() => _ThemeRouteState();
}

class _ThemeRouteState extends State<ThemeRoute> {
  MaterialColor _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
        data: ThemeData(
          // 注意这里是MaterialColor，而不是Color
          primarySwatch: _themeColor,
          iconTheme: IconThemeData(color: _themeColor),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text('主题测试'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite),
                  Icon(Icons.thumb_up),
                  Text('颜色跟随主题')
                ],
              ),
              Theme(
                  data: themeData.copyWith(
                      iconTheme:
                          themeData.iconTheme.copyWith(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite),
                      Icon(Icons.thumb_up),
                      Text('颜色固定')
                    ],
                  ))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _themeColor =
                    _themeColor == Colors.teal ? Colors.pink : Colors.teal;
              });
            },
            child: Icon(Icons.palette),
          ),
        ));
  }
}
