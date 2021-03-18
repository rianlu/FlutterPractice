import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body:
          // ScaleAnimationRoute(),
          BounceAnimationRoute(),
    ),
  ));
}

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationState createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    // 线性
    _animation = Tween(begin: 0.0, end: 300.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'images/test.jpeg',
        width: _animation.value,
        height: _animation.value,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class BounceAnimationRoute extends StatefulWidget {
  @override
  _BounceAnimationRouteState createState() => _BounceAnimationRouteState();
}

class _BounceAnimationRouteState extends State<BounceAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // 正常动画
    // _animationController =
    //     AnimationController(duration: Duration(seconds: 3), vsync: this);
    // _animation =
    //     CurvedAnimation(parent: _animationController, curve: Curves.bounceIn);
    // _animation = Tween(begin: 0.0, end: 300.0).animate(_animation);
    // _animationController.forward();

    // 循环动画
    _animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceIn);
    _animation = Tween(begin: 0.0, end: 300.0).animate(_animation);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // return AnimatedImage(
    //   animation: _animation,
    // );
    return GrowAnimation(
      child: Image.asset('images/test.jpeg'),
      animation: _animation,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation animation})
      : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation animation = listenable;
    return Center(
      child: Image.asset(
        'images/test.jpeg',
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class GrowAnimation extends StatelessWidget {
  GrowAnimation({this.child, this.animation});
  final Widget child;
  final Animation animation;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Container(
            child: child,
            width: animation.value,
            height: animation.value,
          );
        },
        child: child,
      ),
    );
  }
}
