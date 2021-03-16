import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Async Update UI'),
      ),
      body: StreamBuilderRoute(),
    ),
  ));
}

Future<String> macNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => '网络返回数据');
}

Future<Error> macErrorData() async {
  return Future.delayed(Duration(seconds: 2), () => NullThrownError());
}

class FutureBuilderRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: macNetworkData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Contents: ${snapshot.data}');
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  });
}

class StreamBuilderRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: counter(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('没有Stream');
            case ConnectionState.waiting:
              return Text('等待数据...');
            case ConnectionState.active:
              return Text('active: ${snapshot.data}');
            case ConnectionState.done:
              return Text('Stream已关闭');
          }
          return null;
        });
  }
}
