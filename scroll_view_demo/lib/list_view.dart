import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          title: Text('ListView'),
        ),
        body:
            // SingleChildScrollViewTest(),
            // DefaultListView(),
            // ListViewBuilder(),
            // ListViewSeparate(),
            Column(children: [
              ListTile(title: Text('商品列表'),),
              Expanded(child: InfiniteListViewRoute())
            ],)
            ),
  ));
}

class InfiniteListViewRoute extends StatefulWidget {
  @override
  _InfiniteListViewRouteState createState() => _InfiniteListViewRouteState();
}

class _InfiniteListViewRouteState extends State<InfiniteListViewRoute> {
  static const loadingTag = '##loading##';
  var _words = [loadingTag];

  void _receiveData() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        _words.insertAll(_words.length - 1,
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _receiveData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (_words[index] == loadingTag) {
            if (_words.length - 1 < 100) {
              _receiveData();
              return Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              );
            } else {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '没有更多了',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          }
          return CenterListTitle(
            index: index,
            text: _words[index],
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: Colors.grey,);
        },
        itemCount: _words.length);
  }
}

class SingleChildScrollViewTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar(
        child: SingleChildScrollView(
      // Android ClampingScrollPhysics()
      // IOS BouncingScrollPhysics()
      // physics: BouncingScrollPhysics(),
      // 初始滚动位置（并不是滚动方向相反，而是设定初始滚动位置，头或尾）
      reverse: true,
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: str
              .split("")
              .map((e) => Text(
                    e,
                    textScaleFactor: 2.0,
                  ))
              .toList(),
        ),
      ),
    ));
  }
}

// 不急于Sliver懒加载模型
class DefaultListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: TextStyle(fontSize: 50.0, color: Colors.orange),
        child: ListView(
          children: [
            Text('Hello World'),
            Text('Java'),
            Text('Kotlin'),
            Text('Dart'),
            Text('Flutter'),
          ],
        ));
  }
}

// 急于Sliver懒加载模型
class ListViewBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemExtent: 50.0,
        itemCount: 100,
        itemBuilder: (context, index) {
          return CenterListTitle(
            text: '$index',
          );
        });
  }
}

class ListViewSeparate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Divider oddDivider = Divider(
      color: Colors.orange,
    );
    Divider evenDivider = Divider(
      color: Colors.blue,
    );

    return ListView.separated(
      itemCount: 100,
      itemBuilder: (context, index) {
        return CenterListTitle(
          text: '$index',
        );
      },
      separatorBuilder: (context, index) {
        if (index % 2 == 0) {
          return evenDivider;
        } else {
          return oddDivider;
        }
      },
    );
  }
}

class CenterListTitle extends StatelessWidget {
  CenterListTitle({Key key, this.index = -1, this.text}) : super(key: key);

  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (index != -1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('$index'),
          Text('$text')
        ],
      );
    } else {
      return Center(child: Text(text),);
    }
  }
}
