import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Flex Layout'),
      ),
      body: Column(
        children: [FlexTest(), ExpandedTest()],
      ),
    ),
  ));
}

class FlexTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [Text('Head 1'), Text('Head 2')],
        ),
        Flex(
          direction: Axis.vertical,
          children: [Text('Head 1'), Text('Head 2')],
        ),
      ],
    );
  }
}

class ExpandedTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 30.0,
                color: Colors.orange,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30.0,
                color: Colors.green,
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: SizedBox(
            height: 100.0,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30.0,
                    color: Colors.red,
                  ),
                ),
                Spacer(flex: 1),
                Expanded(
                  flex: 2,
                  child: Container(color: Colors.green),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
