import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Padding & Container'),
        actions: [
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Paddingtest(),
          LimitContainerTest(),
          MultiLimitContainerTest(),
          DecoratedBoxTest(),
          ContainerTest()
        ],
      ),
    ),
  ));
}

class Paddingtest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Hello World',
              style: TextStyle(backgroundColor: Colors.blue),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Hello World',
              style: TextStyle(backgroundColor: Colors.orange),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Hello World',
              style: TextStyle(backgroundColor: Colors.red),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
            child: Text(
              'Hello World',
              style: TextStyle(backgroundColor: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

class LimitContainerTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ConstrainedBoxTest(), SizedBoxTest()],
    );
  }
}

class ConstrainedBoxTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: 50.0, minWidth: double.infinity),
          child: Container(
            height: 20.0,
            child: blueBox,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tight(Size(20.0, 20.0)),
          child: yellowBox,
        ),
      ],
    );
  }
}

class SizedBoxTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0,
      height: 80.0,
      child: blueBox,
    );
  }
}

class MultiLimitContainerTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 多重限制有限设置父子中相对较大的值
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),
            child: yellowBox,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
            child: purpleBox,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 90.0, minHeight: 90.0),
          // 去除父ConstrainedBox限制
          // 但是父ConstrainedBox依旧占据90x90的空间
          child: UnconstrainedBox(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 20.0, minHeight: 20.0),
              child: blueBox,
            ),
          ),
        )
      ],
    );
  }
}

Widget blueBox = DecoratedBox(
  decoration: BoxDecoration(color: Colors.blue),
);

Widget yellowBox = DecoratedBox(
  decoration: BoxDecoration(color: Colors.yellow),
);

Widget purpleBox = DecoratedBox(
  decoration: BoxDecoration(color: Colors.purple),
);

class DecoratedBoxTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black54, offset: Offset(2.0, 2.0), blurRadius: 4.0)
        ],
        gradient: LinearGradient(colors: [Colors.red, Colors.orange[700]]),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
        child: Text(
          'Button',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ContainerTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50.0),
      child: Container(
        width: 50.0,
        height: 50.0,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          // 径向渐变
            gradient: RadialGradient(colors: [Colors.red, Colors.orange[700]], center: Alignment.topLeft, radius: .98),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0)
            ]),
        transform: Matrix4.rotationZ(.2),
        child: Text('Hello World', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
