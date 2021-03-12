import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home:
        // MainRoute(),
        CustomScrollViewRoute(),
  ));
}

class MainRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView'),
      ),
      backgroundColor: Colors.blue[200],
      body:
          // GridViewRoute1(),
          // GridViewRoute2(),
          // GridViewRoute3(),
          // GridViewRoute4(),
          InfiniteGridView(),
    );
  }
}

class GridViewRoute1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.0),
      children: [
        Icon(Icons.block),
        Icon(Icons.block),
        Icon(Icons.block),
        Icon(Icons.block),
        Icon(Icons.block),
        Icon(Icons.block),
      ],
    );
  }
}

class GridViewRoute2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: [
        Icon(Icons.alarm),
        Icon(Icons.alarm),
        Icon(Icons.alarm),
        Icon(Icons.alarm),
        Icon(Icons.alarm),
        Icon(Icons.alarm),
      ],
    );
  }
}

class GridViewRoute3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120.0,
        childAspectRatio: 2.0,
      ),
      children: [
        Icon(Icons.games),
        Icon(Icons.games),
        Icon(Icons.games),
        Icon(Icons.games),
        Icon(Icons.games),
        Icon(Icons.games),
      ],
    );
  }
}

class GridViewRoute4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 120.0,
      childAspectRatio: 2.0,
      children: [
        Icon(Icons.book),
        Icon(Icons.book),
        Icon(Icons.book),
        Icon(Icons.book),
        Icon(Icons.book),
        Icon(Icons.book),
      ],
    );
  }
}

class InfiniteGridView extends StatefulWidget {
  @override
  _InfiniteGridViewState createState() => _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {
  List<IconData> _icons = [];

  void _receiveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      setState(() {
        _icons.addAll([Icons.games, Icons.book, Icons.dashboard]);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _receiveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
        ),
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          if (index == _icons.length - 1 && _icons.length < 21) {
            _receiveIcons();
          }
          return Icon(_icons[index]);
        });
  }
}

// 要想多个可滚动组件组合在一起，必须要使用Sliver版的
class CustomScrollViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Demo'),
              background: Image.network(
                'https://book.flutterchina.club/assets/img/book.17ed07e5.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('list item $index'),
              );
            }, childCount: 50),
          ),
        ],
      ),
    );
  }
}
