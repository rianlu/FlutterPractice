import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      title: "命名路由",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: "/",
      // 只会对命名路由生效
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          print("Route Name: $routeName");
          switch (routeName) {
            case "/":
              return MyApp();
              break;
            case "new_page":
              return MyApp();
              break;
            case "new_page_with_arg":
              return EchoRoute();
              break;
            default:
            return MyApp();
          }
        });
      },
      // routes: {
      //   "new_page": (context) => NewRoute(),
      //   "/": (context) => MyApp(),
      //   "new_page_with_arg": (context) => EchoRoute()
      // },
    ),
  );
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          // Navigator.pushNamed(context, "new_page");
          Navigator.pushNamed(context, "new_page_with_arg", arguments: "hi");
        },
        child: Text("New Page"),
      ),
    );
  }
}

class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获得路由参数
    var args = ModalRoute.of(context).settings.arguments;
    print("参数：$args");
    return Scaffold(
      appBar: AppBar(
        title: Text("New Route With Args"),
      ),
      body: Center(
        child: Text("New Route With Args"),
      ),
    );
  }
}
