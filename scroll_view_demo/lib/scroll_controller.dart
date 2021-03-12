import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ScrollControllerRoute()));
}

class ScrollControllerRoute extends StatefulWidget {
  @override
  _ScrollControllerRouteState createState() => _ScrollControllerRouteState();
}

class _ScrollControllerRouteState extends State<ScrollControllerRoute> {
  ScrollController _scrollController = ScrollController();
  bool showToTopBtn = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.offset); //打印滚动位置
      if (_scrollController.offset >= 1000) {
        setState(() {
          showToTopBtn = true;
        });
      } else {
        setState(() {
          showToTopBtn = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll Controller'),
      ),
      body: Scrollbar(
        child: ListView.builder(
            // 显式跟踪滚动位置
            // key: PageStorageKey(1),
            itemExtent: 50.0,
            itemCount: 100,
            controller: _scrollController,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('$index'),
              );
            }),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _scrollController.animateTo(0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return Scaffold(
                //     appBar: AppBar(
                //       title: Text('New Page'),
                //     ),
                //     body: Center(
                //       child: Text('New Page'),
                //     ),
                //   );
                // }));
              }),
    );
  }
}
