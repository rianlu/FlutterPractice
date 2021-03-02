import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:developer';

void main() {
  return runApp(MaterialApp(
    title: "路由测试",
    theme: new ThemeData(primarySwatch: Colors.blue),
    home: RouterTestRoute(),
  ));
}

class TipRoute extends StatelessWidget {
  TipRoute({Key key, @required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.pop(context, "我是返回值"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          onPressed: () async {
            // 返回值为Future
            var result = await Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return TipRoute(
                  text: "我是提示",
                );
              },
            ));
            print("路由返回值：$result");
          },
          child: Text("打开提示页"),
        ),
        RandomWordsWidget()
      ],
    ));
  }
}

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    // 编程式断点
    // debugger(when: wordPair.toString().length > 5);
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(wordPair.toString()),
    );
  }
}

Future<String> loadAsset() async {
  return await rootBundle.loadString("assets/test.json");
}

Future<String> loadAssetWithContext(BuildContext context) async {
  return await DefaultAssetBundle.of(context).loadString("assets/test.json");
}
