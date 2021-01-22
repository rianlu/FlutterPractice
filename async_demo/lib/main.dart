import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => new _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  Map widgets = {"data": List()};

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sample App"),
        ),
        body: getBody());
  }

  // 加载中提示
  Widget getBody() {
    if (widgets["data"].length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
          itemCount: widgets["data"].length,
          itemBuilder: (BuildContext context, int position) {
            return getRow(position);
          });
    }
  }

  Widget getRow(int i) {
    return new Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
            margin: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text('${widgets["data"][i]["id"]}'),
                Expanded(
                  child: Text(
                    '${widgets["data"][i]["name"]}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Text('${widgets["data"][i]["order"]}'),
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ],
            )));
  }

  loadData() async {
    String dataURL = "https://wanandroid.com/wxarticle/chapters/json";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = jsonDecode(response.body);
    });
  }
}
