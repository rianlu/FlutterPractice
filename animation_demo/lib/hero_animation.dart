import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Hero Animation'),
      ),
      body: MainRoute(),
    ),
  ));
}

class MainRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
              tag: 'avatar',
              child: ClipOval(
                child: Image.asset(
                  'images/test.jpeg',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return FadeTransition(
                      opacity: animation,
                      child: NewPageRoute(),
                    );
                  }));
                },
                child: Text('查看大图')),
          )
        ],
      ),
    );
  }
}

class NewPageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Center(
        child: Hero(tag: 'avatar', child: Image.asset('images/test.jpeg')),
      ),
    );
  }
}
