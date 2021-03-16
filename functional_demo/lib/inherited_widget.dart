import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Inherited Widget'),
      ),
      body: InheritedWidgetRoute(),
    ),
  ));
}

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  final int data;

  static ShareDataWidget of(BuildContext context) {
    // 此方式会注册依赖关系，实现更新子组件，即触发didChangeDependencies
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
    // 没有依赖关系，所以不会更新子组件
    // return context.getElementForInheritedWidgetOfExactType<ShareDataWidget>().widget;
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class _TextWidget extends StatefulWidget {
  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<_TextWidget> {
  @override
  Widget build(BuildContext context) {
    // 如果不使用ShareDataWidget的数据，则不会触发didChangeDependencies
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Dependencies Change');
  }
}

class InheritedWidgetRoute extends StatefulWidget {
  _InheritedWidgetRouteState createState() => _InheritedWidgetRouteState();
}

class _InheritedWidgetRouteState extends State<InheritedWidgetRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: _TextWidget(),
            ),
            // 原RaisedButton
            ElevatedButton(
                child: Text('Increment'),
                onPressed: () => setState(() => ++count))
          ],
        ),
      ),
    );
  }
}
