import 'package:flutter/material.dart';

void main() {
  return runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          title: Text('Image'),
        ),
        body: Column(
          children: [ImageDisplay(), IconDisplay(), CustomIconDisplay()],
        )),
  ));
}

class ImageDisplay extends StatelessWidget {
  final String assetImage = 'iamges/avatar.png';
  final String networkImage = 'https://pcdn.flutterchina.club/imgs/3-17.png';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 从asset中加载图片
        // Image(image: AssetImage(assetImage), width: 100.0,),
        Image.asset(
          assetImage,
          width: 100.0,
        ),
        // 从网络加载图片
        // Image(image: NetworkImage(networkImage), width: 100.0,)
        Image.network(
          networkImage,
          width: 100.0,
        ),
        // fit type
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Row(
            children: [
              Image.network(
                networkImage,
                width: 100.0,
                height: 50.0,
                fit: BoxFit.fill,
              ),
              Image.network(
                networkImage,
                width: 100.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              Image.network(
                networkImage,
                width: 100.0,
                height: 50.0,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              Image.network(
                networkImage,
                width: 100.0,
                height: 50.0,
                fit: BoxFit.fitWidth,
              ),
              Image.network(
                networkImage,
                width: 50.0,
                height: 100.0,
                fit: BoxFit.fitHeight,
              ),
              Image.network(
                networkImage,
                width: 50.0,
                height: 50.0,
                fit: BoxFit.none,
              ),
            ],
          ),
        ),
        // Color BlendMode
        Image.network(
          networkImage,
          width: 100.0,
          color: Colors.blue,
          colorBlendMode: BlendMode.difference,
        ),
        Image.asset(
          assetImage,
          width: 100.0,
          height: 50.0,
          repeat: ImageRepeat.repeatX,
        ),
      ],
    );
  }
}

class IconDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              Icons.accessible,
              color: Colors.green,
            ),
            Icon(
              Icons.error,
              color: Colors.green,
            ),
            Icon(
              Icons.fingerprint,
              color: Colors.green,
            ),
          ],
        )
      ],
    );
  }
}

class CustomIconDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          MyIcons.book,
          color: Colors.purple,
        ),
        Icon(
          MyIcons.wechat,
          color: Colors.green,
        )
      ],
    );
  }
}

/// 在iconfont.cn中选择图标加入购物车，选择下载代码即可得到ttf文件
/// codePoint的值在iconfont.json中
/// 添加完字体资源后需要重新运行，热重载会无法加载字体资源
class MyIcons {
  static const IconData book =
      const IconData(0xe718, fontFamily: 'myIcon', matchTextDirection: true);

  static const IconData wechat =
      const IconData(0xe6ca, fontFamily: 'myIcon', matchTextDirection: true);
}
