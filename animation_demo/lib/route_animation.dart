import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Route Animation'),
      ),
      body: MainRoute(),
    ),
  ));
}

class MainRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('New Page'),
        onPressed: () => Navigator.push(context,
            // Android
            // MaterialPageRoute(
            //   builder: (context) {
            //     return NewPageRoute();
            //   },
            // ),

            // IOS
            // CupertinoPageRoute(
            //   builder: (context) {
            //     return NewPageRoute();
            //   },
            // ),

            // Custom
            // PageRouteBuilder(
            //   transitionDuration: Duration(milliseconds: 500),
            //   pageBuilder: (context, animation, secondaryAnimation) {
            //     return FadeTransition(
            //       opacity: animation,
            //       child: NewPageRoute(),
            //     );
            //   },
            // ),

            // 自定义PageRoute
            FadePageRoute(builder: (context) {
          return NewPageRoute();
        })),
      ),
    );
  }
}

class NewPageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: Text('New Page'),
      ),
    );
  }
}

class FadePageRoute extends PageRoute {
  FadePageRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  Duration duration = Duration(milliseconds: 500);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // 返回时不执行动画
    if (isActive) {
      return FadeTransition(opacity: animation, child: builder(context));
    } else {
      return Padding(padding: EdgeInsets.zero);
    }
  }
}
