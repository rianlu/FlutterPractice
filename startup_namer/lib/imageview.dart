import 'package:flutter/material.dart';

class ImageViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget iamgeSection = new Image.asset(
      'images/lake.jpeg',
      height: 240.0,
      fit: BoxFit.cover,
    );

    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(children: [
        new Expanded(
            child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: new Text('Oeschinen Lake Campground',
                  style: new TextStyle(fontWeight: FontWeight.bold)),
            ),
            new Text(
              'Kandersteg, Switzerland',
              style: new TextStyle(
                color: Colors.grey[500],
              ),
            )
          ],
        )),
        new FavoriteWidget()
      ]),
    );

    Column buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;
      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(icon, color: color),
          new Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: new Text(label,
                  style: new TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: color)))
        ],
      );
    }

    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE')
        ],
      ),
    );

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        'Many Many Text ...',
        softWrap: true,
      ),
    );

    return new MaterialApp(
      title: 'Image View',
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new Scaffold(
        body: new ListView(
          children: [iamgeSection, titleSection, textSection, buttonSection],
        ),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        new Container(
          padding: new EdgeInsets.all(0.0),
          child: new IconButton(
            icon: _isFavorited ? new Icon(Icons.star) : new Icon(Icons.star_border),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          )
        ),
        new SizedBox(
          width: 18.0,
          child: new Container(
            child: new Text('$_favoriteCount')
          )
        )
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount --;
        _isFavorited = false;
      } else {
        _favoriteCount ++;
        _isFavorited = true;
      }
    });
  }
}
